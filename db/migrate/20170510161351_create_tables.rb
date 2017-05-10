class CreateTables < ActiveRecord::Migration[5.1]
  def change
    create_table(:recipes) do |t|
      t.column(:title,:string)

      t.timestamps()
    end
    create_table(:ingredients) do |t|
      t.column(:name,:string)
      t.column(:quantity,:string)
      t.column(:recipe_id,:integer)

      t.timestamps()
    end
    create_table(:instructions) do |t|
      t.column(:step,:integer)
      t.column(:instruction,:string)
      t.column(:recipe_id,:integer)

      t.timestamps()
    end
    create_table(:recipes_tags) do |t|
      t.column(:recipe_id,:integer)
      t.column(:tag_id,:integer)

      t.timestamps()
    end
    create_table(:tags) do |t|
      t.column(:title,:string)

      t.timestamps()
    end
  end
end
