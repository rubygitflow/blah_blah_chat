class CreateHighlights < ActiveRecord::Migration[7.1]
  def change
    create_table :highlights do |t|
      t.belongs_to :post, null: false, foreign_key: true, index: { unique: true }

      t.datetime(:created_at, null: false)
    end
  end
end
