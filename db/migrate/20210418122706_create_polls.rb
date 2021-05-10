# frozen_string_literal: true

class CreatePolls < ActiveRecord::Migration[6.1]
  def change
    create_table :polls do |t|
      t.references :company
      t.string :uuid, limit: 36, null: false, index: true, unique: true
      t.boolean :active, default: false
      t.string :name
      t.string :title
      t.text :description
      t.integer :poll_votes_count, default: 0
      t.string :slug, index: true
      t.boolean :show_options, default: true
      t.boolean :show_comments, default: true
      t.timestamps
    end

    create_table :poll_options do |t|
      t.references :poll
      t.string :uuid, limit: 36, null: false, index: true, unique: true
      t.string :title
      t.integer :category, default: 0
      t.string :value
      t.timestamps
    end

    create_table :poll_votes do |t|
      t.references :poll
      t.string :uuid, limit: 36, null: false, index: true, unique: true
      t.string :result
      t.string :option_title
      t.text :comment
      t.timestamps
    end
  end
end
