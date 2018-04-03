class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :author
      t.text :comment
      t.integer :entry_id

      t.timestamps null: false
    end
  end
end
