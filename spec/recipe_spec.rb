require 'spec_helper'

describe(Recipe) do
  describe('.ingredients') do
    it('will list all ingredients for a recipe') do
      recipe = Recipe.create({:title => 'test'})
      ingredient1 = Ingredient.create({:name => 'garlic', :quantity => '5 cloves', :recipe_id => recipe.id})
      expect(recipe.ingredients.first).to eq (ingredient1)
    end
  end

end
