class RecipesController < ApplicationController

  def show
    recipe = Recipe.find(params[:id])
    render json: recipe, include: :ingredients
  end
end
