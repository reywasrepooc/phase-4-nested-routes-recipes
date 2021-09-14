require 'rails_helper'

RSpec.describe "Recipes", type: :request do
  let!(:recipe) do
    recipe = Recipe.create(name: "Oatmeal", description: "A healthy breakfast")
    recipe.ingredients.create(name: "Rolled Oats", quantity: "1/3 cup")
    recipe.ingredients.create(name: "Maple Syrup", quantity: "1 tablespoon")
    recipe
  end

  describe "GET /recipes/:id" do
    it 'returns a recipe with an array of all ingredients associated with that recipe' do
      get "/recipes/#{recipe.id}"

      expect(response.body).to include_json({
        id: a_kind_of(Integer),
        name: "Oatmeal",
        description: "A healthy breakfast",
        ingredients: [
          {
            id: a_kind_of(Integer),
            name: "Rolled Oats",
            quantity: "1/3 cup"
          }
        ]
      })
    end
  end
end
