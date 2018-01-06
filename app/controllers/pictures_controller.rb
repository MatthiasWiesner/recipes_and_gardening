require 'rmagick'

class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  before_action :check_loggedin, except: [:show]

  # GET /pictures
  # GET /pictures.json
  def index
    @pictures = Picture.all
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show
    @picture = Picture.find(params[:id])
    content = @picture.content
    if params[:size].present?
      if params[:size] == 'small'
        content = @picture.small
      elsif params[:size] == 'thumbnail'
        content = @picture.thumbnail
      end
    end
    send_data(content, :type => @picture.mime_type, :filename => @picture.name, :disposition => 'inline')
  end

  # GET /pictures/new
  def new
    @picture = Picture.new
  end

  # GET /pictures/1/edit
  def edit
  end

  # POST /pictures
  def create
    if params[:recipe_id].present?
      create_recipe_picture(params[:picture], params[:recipe_id])
      redirect_back fallback_location: recipes_url
    elsif params[:gardening_id].present?
      create_gardening_picture(params[:picture], params[:gardening_id])
      redirect_back fallback_location: gardenings_url
    elsif params[:blog_id].present?
      create_blog_picture(params[:picture], params[:blog_id])
      redirect_back fallback_location: blogs_url
    else
      redirect_to pictures_path
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    destroy_picture(params[:id])

    if params[:recipe_id].present?
      redirect_back fallback_location: recipes_url
    elsif params[:gardening_id].present?
      redirect_back fallback_location: gardenings_url
    else
      redirect_to pictures_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_picture
      @picture = Picture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def picture_params
      params.fetch(:picture, {})
    end
end
