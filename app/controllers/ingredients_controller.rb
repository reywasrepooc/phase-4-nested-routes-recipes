class IngredientsController < ApplicationController

  def index
    ingredients = Ingredient.all
    render json: ingredients, include: :recipe
  end

end
