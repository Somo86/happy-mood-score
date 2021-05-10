# frozen_string_literal: true

class CreateTeams < ActiveRecord::Migration[6.1]
  def change
    create_table :teams do |t|
      t.references :company
      t.string :uuid, limit: 36, null: false, index: true, unique: true
      t.string :name
      t.integer :employees_count, default: 0
      t.integer :hms, default: 0
      t.integer :involvement, default: 0
      t.integer :results_good, default: 0
      t.integer :results_bad, default: 0
      t.integer :results_fine, default: 0
      t.integer :high5_received, default: 0
      t.integer :high5_given, default: 0
      t.integer :feedback_given, default: 0
      t.integer :comments, default: 0
      t.timestamps
    end
  end
end
