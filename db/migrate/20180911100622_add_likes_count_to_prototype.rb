class AddLikesCountToPrototype < ActiveRecord::Migration[5.0]
  def change
    add_column :prototypes, :likes_count, :integer
  end
end
