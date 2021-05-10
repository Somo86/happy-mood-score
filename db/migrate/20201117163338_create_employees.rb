# frozen_string_literal: true

class CreateEmployees < ActiveRecord::Migration[6.0]
  def change
    create_table :employees do |t|
      t.references :user
      t.references :language
      t.references :company
      t.references :team
      t.string :uuid, limit: 36, null: false, index: true, unique: true
      t.string :name, index: true
      t.string :email, index: true, unique: true
      t.string :slack_username
      t.string :api_key, limit: 36
      t.string :push_key
      t.string :external_id, index: true
      t.integer :hms, default: 0
      t.integer :involvement, default: 0
      t.integer :results_good, default: 0
      t.integer :results_bad, default: 0
      t.integer :results_fine, default: 0
      t.integer :high5_received, default: 0
      t.integer :high5_given, default: 0
      t.integer :feedback_given, default: 0
      t.integer :comments, default: 0
      t.integer :points, default: 0
      t.integer :role, default: 0, null: false
      t.string :level_name
      t.datetime :deleted_at
      t.timestamps
    end

    add_index :employees, :api_key, unique: true
  end
end
