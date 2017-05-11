class Recipe < ActiveRecord::Base
  has_many(:ingredients, dependent: :destroy)
  has_many(:instructions, dependent: :destroy)
  has_and_belongs_to_many(:tags)

end

class Tag < ActiveRecord::Base
  has_and_belongs_to_many(:recipes)

end

class Ingredient < ActiveRecord::Base
  belongs_to(:recipes)
  before_save(:capitalize)

  def self.recipes (name)
    results = []
    ingredients = Ingredient.all.where({:name => name})
    recipe_ids = ingredients.map(&:recipe_id)
    recipe_ids.each do |recipe_id|
      results.push(Recipe.find(recipe_id))
    end
    results
  end
end

class Instruction < ActiveRecord::Base
  belongs_to(:recipes)

end
