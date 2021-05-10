# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.belongs_to :company
      t.string :uuid, limit: 36, null: false, index: true, unique: true
      t.string :name, limit: 50, null: false
      t.integer :category, index: true, default: 0
      t.string :image_path
      t.text :description
      t.string :activity_description
      t.integer :value, default: 0, null: false
      t.timestamps
    end
  end
end
