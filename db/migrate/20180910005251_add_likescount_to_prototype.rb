class AddLikescountToPrototype < ActiveRecord::Migration[5.0]
  def change
    add_column :prototypes, :likescount, :integer
  end
end
