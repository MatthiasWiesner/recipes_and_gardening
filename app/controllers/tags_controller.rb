class TagsController < ApplicationController
  before_action :check_loggedin, except: [:show]

  def create
    if params[:recipe_tags].present?
      add_tags_to_recipe(params[:recipe_tags], params[:recipe_id])
      redirect_back fallback_location: recipes_url
    elsif params[:gardening_tags].present?
      add_tags_to_gardening(params[:gardening_tags], params[:gardening_id])
      redirect_back fallback_location: gardenings_url
    end
  end

  def destroy
  end
end
