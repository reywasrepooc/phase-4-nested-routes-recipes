require 'rails_helper'

RSpec.describe "Ingredients", type: :request do
  before do
    u1 = Recipe.create(name: "Oatmeal", description: "A healthy breakfast")
    u2 = Recipe.create(name: "Smoothie", description: "A drinkable meal")
    u1.ingredients.create(name: "Rolled Oats", quantity: "1/3 cup")
    u2.ingredients.create(name: "Mixed Berries", quantity: "1 cup")
  end

  let!(:recipe) { Recipe.first }
  let!(:ingredient) { recipe.ingredients.first }

  describe "GET /recipes/:recipe_id/ingredients" do
    it 'returns an array of all ingredients belonging to a recipe' do
      get "/recipes/#{recipe.id}/ingredients"

      expect(response.body).to include_json([
        {
          id: a_kind_of(Integer),
          name: "Rolled Oats",
          quantity: "1/3 cup",
          recipe_id: recipe.id
        }
      ])

      expect(response.body).not_to include_json([
        {
          name: "Mixed Berries",
          quantity: "1 cup"
        }
      ])
    end

    it 'returns a 404 response if the recipe is not found' do
      get "/recipes/bad_id/ingredients"

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "GET /recipes/:recipe_id/ingredients/:id" do
    it 'returns the ingredient with the matching id' do
      get "/recipes/#{recipe.id}/ingredients/#{ingredient.id}"

      expect(response.body).to include_json({
        id: a_kind_of(Integer),
        name: "Rolled Oats",
        quantity: "1/3 cup",
        recipe_id: recipe.id
      })
    end

    it 'returns a 404 response if the ingredient is not found' do
      get "/recipes/#{recipe.id}/ingredients/bad_id"

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST /recipes/:recipe_id/ingredients" do
    let!(:ingredient_params) { { name: "Maple Syrup", quantity: "1 tablespoon" } }

    it 'creates a new ingredient belonging to a recipe' do
      expect { post "/recipes/#{recipe.id}/ingredients", params: ingredient_params }.to change(recipe.ingredients, :count).by(1)
    end

    it 'returns the newly created ingredient' do
      post "/recipes/#{recipe.id}/ingredients", params: ingredient_params

      expect(response.body).to include_json({
        id: a_kind_of(Integer),
        name: "Maple Syrup",
        quantity: "1 tablespoon",
        recipe_id: recipe.id
      })
    end

    it 'returns a 201 created status if the ingredient was created' do
      post "/recipes/#{recipe.id}/ingredients", params: ingredient_params

      expect(response).to have_http_status(:created)
    end

    it 'returns a 404 response if the recipe is not found' do
      get "/recipes/bad_id/ingredients"

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "GET /ingredients" do
    it 'returns an array of all ingredients with recipe info' do
      get '/ingredients'

      expect(response.body).to include_json([
        {
          id: a_kind_of(Integer),
          name: "Rolled Oats",
          quantity: "1/3 cup",
          recipe: {
            id: a_kind_of(Integer),
            name: "Oatmeal",
            description: "A healthy breakfast"
          }
        }
      ])
    end
  end
end
