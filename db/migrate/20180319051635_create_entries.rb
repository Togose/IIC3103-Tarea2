class CreateEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :entries do |t|
      t.string :title
      t.text :subhead
      t.text :body
      t.timestamps
    end
  end
end
