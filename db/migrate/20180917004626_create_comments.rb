class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.references :prototype ,foreign_key: true
      t.references :user,foreign_key: true
      t.text :text, null:false
      t.timestamps
    end
  end
end
