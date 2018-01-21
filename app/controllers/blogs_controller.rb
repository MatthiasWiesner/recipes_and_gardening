require 'redcarpet'

class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :destroy]
  before_action :check_loggedin, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_markdown, only: [:index, :show]

  # GET /blogs
  # GET /blogs.json
  def index
    @blogs = Blog.all.order(created_at: :desc)
    @blogs.each do |b|
      b.description = @markdown.render(b.description)
    end
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
    redirect_to action: :index if not (@blog.published or logged_in?)

    all_links = Hash.new{|h, k| h[k] = []}

    # links for gardening and recipes
    Tag.all.each do |tag|
      if @blog.description.include?(tag.tag)
        @blog.description = parse_string(@blog.description, tag, all_links)
      end
      if @blog.content.include?(tag.tag)
        @blog.content = parse_string(@blog.content, tag, all_links)
      end
    end

    related = ""
    all_links.each do |recipe_or_gardening, tags|
      tagnames = tags.map { |t| t.tag }.uniq
      if recipe_or_gardening.is_a? Recipe
        path = recipe_path(recipe_or_gardening.id)
      elsif recipe_or_gardening.is_a? Gardening
        path = gardening_path(recipe_or_gardening.id)
      end
      related << "[#{ recipe_or_gardening.name } (Tags: #{ tagnames.join(", ") })](#{path})\n"
    end
    @related = @markdown.render(related)

    @blog.description = @markdown.render(@blog.description)
    @blog.content = @markdown.render(@blog.content)
  end

  def newest
    @blog = Blog.where(published: true).order("created_at").last
    if @blog.present? and (@blog.published or logged_in?)
      redirect_to blog_path(@blog.id)
    else
      @blogs = Blog.all
      render :index
    end
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = Blog.new(blog_params.except(:picture))
    if @blog.save
      flash[:success] = "Blog wurde gespeichert"
      redirect_to @blog
    else
      render :new
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    if @blog.update(blog_params.except(:picture))
      redirect_to @blog
    else
      render :edit
    end
  end

  # DELETE /blogs/1
  # DELETE /blogs/1.json
  def destroy
    destroy_blog_pictures(@blog.id)
    @blog.destroy
    redirect_to blogs_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:name, :description, :content, :published, :picture)
    end

    def set_markdown
      renderer = Redcarpet::Render::HTML.new(no_links: false, hard_wrap: true)
      @markdown = Redcarpet::Markdown.new(renderer, autolink: true, tables: true)
    end

    def parse_string(s, tag, all_links)
      tag.gardenings.all.each do | gardening |
        next if !gardening.published
        all_links[gardening] << tag

        # return if tag is already part of a markdown link
        p = /\[[\w]*#{tag.tag}[\w]*\]/
        return s if s.match(p)

        link = "[#{tag.tag}](#{gardening_path(gardening.id)})"
        s = s.gsub(tag.tag, link)
        return s
      end
      tag.recipes.all.each do | recipe |
        next if !recipe.published
        all_links[recipe] << tag

        # return if tag is already part of a markdown link
        p = /\[[\w]*#{tag.tag}[\w]*\]/
        return s if s.match(p)

        link = "[#{tag.tag}](#{recipe_path(recipe.id)})"
        s = s.gsub(tag.tag, link)
        return s
      end
    end
end
