# frozen_string_literal: true

class CreateNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :notes do |t|
      t.references :employee
      t.references :receiver
      t.string :uuid, limit: 36, null: false, index: true, unique: true
      t.text :description
      t.boolean :done, default: false
      t.boolean :shared, default: false, index: true
      t.timestamps
    end
  end
end
