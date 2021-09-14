class RecipesController < ApplicationController

  def show
    recipe = Recipe.find_by(id: params[:id])
    render json: recipe, include: :ingredients
  end

end
