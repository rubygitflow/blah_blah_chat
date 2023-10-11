# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.references :chat, null: false, foreign_key: true
      t.text :body, null: false

      t.timestamps
    end
  end
end
