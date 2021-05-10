# frozen_string_literal: true

class CreateVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :votes do |t|
      t.references :company
      t.references :team
      t.references :employee
      t.string :uuid, limit: 36, null: false, index: true, unique: true
      t.string :token, limit: 60, index: true
      t.integer :result, index: true
      t.text :description
      t.boolean :recent, default: true, index: true
      t.datetime :generated_at
      t.timestamps
    end

    create_table :replies do |t|
      t.string :uuid, limit: 36, null: false, index: true, unique: true
      t.references :vote
      t.references :employee
      t.text :description
      t.timestamps
    end
  end
end
