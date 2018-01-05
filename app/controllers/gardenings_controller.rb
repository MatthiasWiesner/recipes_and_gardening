require 'redcarpet'

class GardeningsController < ApplicationController
  before_action :set_gardening, only: [:show, :edit, :update, :destroy]
  before_action :check_loggedin, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_markdown, only: [:index, :show]

  # GET /gardenings
  # GET /gardenings.json
  def index
    @gardenings = Gardening.all
    @gardenings.each do |g|
      g.description = @markdown.render(g.description)
    end
  end

  # GET /gardenings/1
  # GET /gardenings/1.json
  def show
    redirect_to action: :index if not (@gardening.published or logged_in?)

    recipe_links = Hash.new{|h, k| h[k] = []}
    get_common_gardening_recipes(@gardening.id).each do |recipe_tag|
      recipe = Recipe.find(recipe_tag.recipe_id)
      next if !recipe.published
      tag = Tag.find(recipe_tag.tag_id)
      recipe_links[recipe] << tag
    end

    related = ""
    recipe_links.each do |recipe, tags|
      tagnames = tags.map { |t| t.tag }
      related << "[#{ recipe.name } (Tags: #{ tagnames.join(", ") })](#{recipe_path(recipe.id)})\n"
    end
    @related = @markdown.render(related)

    @gardening.description = @markdown.render(@gardening.description)
    @gardening.content = @markdown.render(@gardening.content)
  end

  # GET /gardenings/new
  def new
    @gardening = Gardening.new
  end

  # GET /gardenings/1/edit
  def edit
  end

  # POST /gardenings
  # POST /gardenings.json
  def create
    @gardening = Gardening.new(gardening_params.except(:picture))
    if @gardening.save
      if gardening_params[:picture].present?
        create_gardening_picture(gardening_params[:picture], @gardening.id)
      end
      flash[:success] = "Gartentipp wurde gespeichert"
      redirect_to @gardening
    else
      render 'new'
    end
  end

  # PATCH/PUT /gardenings/1
  # PATCH/PUT /gardenings/1.json
  def update
    if gardening_params[:picture].present?
      create_gardening_picture(gardening_params[:picture], @gardening.id)
    end
    if @gardening.update(gardening_params.except(:picture))
      redirect_to @gardening
    else
      render :edit
    end
  end

  # DELETE /gardenings/1
  # DELETE /gardenings/1.json
  def destroy
    destroy_gardening_pictures(@gardening.id)
    @gardening.destroy
    redirect_to gardenings_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gardening
      @gardening = Gardening.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gardening_params
      params.require(:gardening).permit(:name, :description, :content, :published, :picture)
    end

    def set_markdown
      renderer = Redcarpet::Render::HTML.new(no_links: false, hard_wrap: true)
      @markdown = Redcarpet::Markdown.new(renderer, autolink: true, tables: true)
    end
end
