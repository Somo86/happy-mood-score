# frozen_string_literal: true

class CreateHistoricalLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :historical_logs do |t|
      t.references :employee
      t.references :team
      t.references :company
      t.string :uuid, limit: 36, null: false, index: true, unique: true
      t.integer :hms, default: 0
      t.integer :involvement, default: 0
      t.integer :points, default: 0
      t.string :level_name
      t.integer :high5_total, default: 0
      t.integer :high5_received, default: 0
      t.integer :high5_given, default: 0
      t.integer :feedback_given, default: 0
      t.integer :company_ranking, default: 0
      t.integer :team_ranking, default: 0
      t.integer :results_good, default: 0
      t.integer :results_bad, default: 0
      t.integer :results_fine, default: 0
      t.integer :total_votes, default: 0
      t.integer :total_count, default: 0
      t.integer :total_pending, default: 0
      t.integer :active_employees, default: 0
      t.integer :comments, default: 0
      t.date :generated_on, index: true
      t.timestamps
    end
  end
end
