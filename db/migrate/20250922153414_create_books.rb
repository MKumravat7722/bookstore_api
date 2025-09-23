class CreateBooks < ActiveRecord::Migration[7.2]
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.text :content
      t.references :author, null: false, foreign_key: { to_table: :users}
      t.datetime :published_at

      t.timestamps
    end
  end
end
