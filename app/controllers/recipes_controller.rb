require 'redcarpet'

class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  before_action :check_loggedin, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_markdown, only: [:index, :show]

  def index
    @recipes = Recipe.all()
    @recipes.each do |r|
      r.description = @markdown.render(r.description)
    end
  end

  def show
    redirect_to action: :index if not (@recipe.published or logged_in?)

    gardening_links = Hash.new{|h, k| h[k] = []}
    get_common_recipe_gardenings(@recipe.id).each do |gardening_tag|
      gardening = Gardening.find(gardening_tag.gardening_id)
      next if !gardening.published
      
      tag = Tag.find(gardening_tag.tag_id)
      link = "[#{tag.tag}](#{gardening_path(gardening.id)})"
      if @recipe.ingredients.include?(tag.tag)
        @recipe.ingredients = @recipe.ingredients.gsub(tag.tag, link)
      end
      gardening_links[gardening] << tag
    end

    related = ""
    gardening_links.each do |gardening, tags|
      tagnames = tags.map { |t| t.tag }
      related << "[#{ gardening.name } (Tags: #{ tagnames.join(", ") })](#{gardening_path(gardening.id)})\n"
    end
    @related = @markdown.render(related)

    @recipe.description = @markdown.render(@recipe.description)
    @recipe.ingredients = @markdown.render(@recipe.ingredients)
    @recipe.preparation = @markdown.render(@recipe.preparation)
  end

  def new
    @recipe = Recipe.new
  end

  def edit
    @recipe_tags = get_recipe_tags(@recipe.id)
  end

  def create
    @recipe = Recipe.new(recipe_params.except(:picture))
    if @recipe.save
      if recipe_params[:picture].present?
        create_recipe_picture(recipe_params[:picture], @recipe.id)
      end
      flash[:success] = "Rezept wurde gespeichert"
      redirect_to @recipe
    else
      render :new
    end
  end
  
  def update
    if recipe_params[:picture].present?
      create_recipe_picture(recipe_params[:picture], @recipe.id)
    end
    if @recipe.update(recipe_params.except(:picture))
      redirect_to @recipe
    else
      render :edit
    end
  end

  def destroy
    destroy_recipe_pictures(@recipe.id)
    @recipe.destroy
    redirect_to recipes_path
  end

  private
    def recipe_params
      params.require(:recipe).permit(:name, :description, :published, :ingredients, :preparation, :picture)
    end

    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    def set_markdown
      renderer = Redcarpet::Render::HTML.new(no_links: false, hard_wrap: true)
      @markdown = Redcarpet::Markdown.new(renderer, autolink: true, tables: true)
    end
end
