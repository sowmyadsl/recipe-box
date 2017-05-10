require 'spec_helper'

describe(Recipe) do
  describe('.ingredients') do
    it('will list all ingredients for a recipe') do
      recipe = Recipe.create({:title => 'test'})
      ingredient1 = Ingredient.create({:name => 'garlic', :quantity => '5 cloves', :recipe_id => recipe.id})
      expect(recipe.ingredients.first).to eq (ingredient1)
    end
  end

  describe('.initialize') do
    it('will create a link between a tag and a recipe') do
      recipe = Recipe.create({:title => 'recipe_test'})
      tag = Tag.create({:title => 'tag_test'})
      recipe.tags.push(tag)
      expect(recipe.tags).to eq ([tag])
    end
  end

end
