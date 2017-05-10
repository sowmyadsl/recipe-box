require("bundler/setup")
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get '/' do
  @recipes = Recipe.all
  @tags = Tag.all
  erb :index
end

get '/create_recipe' do
  erb :create_recipe
end

post '/create_recipe' do
  title = params.fetch('title')
  Recipe.create({:title => title})
  redirect '/'
end

get '/edit_recipe/:id' do
  id = params.fetch('id').to_i
  @recipe = Recipe.find(id)
  @tags = Tag.all
  # @recipe_tags = @recipe
  @ingredients = @recipe.ingredients
  @instructions = @recipe.instructions.order(:step)
  erb :edit_recipe
end

patch '/edit_recipe/:id/edit_recipe_name' do
  id = params.fetch('id').to_i
  title = params.fetch('title')
  @recipe = Recipe.find(id)
  @recipe.update({:title => title})
  redirect "/edit_recipe/#{id}"
end

post '/edit_recipe/:id/add_tag' do
  recipe_id = params.fetch('id').to_i
  tag_id = params.fetch('tag_id').to_i
  RecipeTag.create({:recipe_id => recipe_id, :tag_id => tag_id})
  redirect "/edit_recipe/#{recipe_id}"
end

delete '/edit_recipe/:id/delete_recipe' do
  id = params.fetch('id').to_i
  recipe = Recipe.find(id)
  recipe.destroy
  redirect '/'
end

post '/edit_recipe/:id/create_ingredient' do
  recipe_id = params.fetch('id').to_i
  ingredient = params.fetch('ingredient')
  quantity = params.fetch('quantity')
  Ingredient.create({:name => ingredient, :quantity => quantity, :recipe_id => recipe_id})
  redirect "/edit_recipe/#{recipe_id}"
end

post '/edit_recipe/:id/create_instruction' do
  recipe_id = params.fetch('id').to_i
  instruction = params.fetch('instruction')
  step = params.fetch('step').to_i
  Instruction.create({:instruction => instruction, :step => step, :recipe_id => recipe_id})
  redirect "/edit_recipe/#{recipe_id}"
end

get '/edit_recipe/:recipe_id/delete_ingredient/:id' do
  recipe_id = params.fetch('recipe_id').to_i
  id = params.fetch('id').to_i
  ingredient = Ingredient.find(id)
  ingredient.destroy
  redirect "/edit_recipe/#{recipe_id}"
end

get '/edit_recipe/:recipe_id/delete_instruction/:id' do
  recipe_id = params.fetch('recipe_id').to_i
  id = params.fetch('id').to_i
  instruction = Instruction.find(id)
  instruction.destroy
  redirect "/edit_recipe/#{recipe_id}"
end

get '/edit_recipe/:recipe_id/edit_ingredient/:id' do
  id = params.fetch('id').to_i
  @recipe_id = params.fetch('recipe_id').to_i
  @ingredient = Ingredient.find(id)
  erb(:edit_ingredient)
end

patch '/edit_recipe/:recipe_id/edit_ingredient/:id' do
  recipe_id = params.fetch('recipe_id').to_i
  id = params.fetch('id').to_i
  ingredient_value = params.fetch('ingredient')
  quantity = params.fetch('quantity')
  ingredient = Ingredient.find(id)
  ingredient.update({:name => ingredient_value, :quantity => quantity})
  redirect "/edit_recipe/#{recipe_id}"
end

get '/edit_recipe/:recipe_id/edit_instruction/:id' do
  id = params.fetch('id').to_i
  @recipe_id = params.fetch('recipe_id').to_i
  @instruction = Instruction.find(id)
  erb(:edit_instruction)
end

patch '/edit_recipe/:recipe_id/edit_instruction/:id' do
  recipe_id = params.fetch('recipe_id').to_i
  id = params.fetch('id').to_i
  instruction_value = params.fetch('instruction')
  step = params.fetch('step').to_i
  instruction = Instruction.find(id)
  instruction.update({:instruction => instruction_value, :step => step})
  redirect "/edit_recipe/#{recipe_id}"
end

get '/create_tag' do
  erb :create_tag
end

post '/create_tag' do
  title = params.fetch('title')
  Tag.create({:title => title})
  redirect '/'
end
