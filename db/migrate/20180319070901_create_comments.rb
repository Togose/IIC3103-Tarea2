class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :author
      t.text :comment
      t.references :entry, foreign_key: true

      t.timestamps null: false
    end
  end
end
