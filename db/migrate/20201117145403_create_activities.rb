# frozen_string_literal: true

class CreateActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :activities do |t|
      t.string :uuid, limit: 36, null: false, index: true, unique: true
      t.references :employee
      t.references :event
      t.bigint :sender_id, index: true
      t.integer :value, default: 0
      t.text :description
      t.timestamps
    end
  end
end
