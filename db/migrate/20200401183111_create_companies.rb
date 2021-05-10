# frozen_string_literal: true

class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.references :language
      t.string :uuid, limit: 36, null: false, index: true, unique: true
      t.string :name
      t.string :email
      t.string :slug, index: true
      t.string :vat_number
      t.string :address
      t.string :postal_code
      t.string :city
      t.string :country
      t.integer :date_format, default: 1
      t.string :timezone
      t.integer :frequency
      t.integer :weekday
      t.string :hour
      t.datetime :next_request_at
      t.integer :hms, default: 0
      t.integer :involvement, default: 0
      t.integer :results_good, default: 0
      t.integer :results_bad, default: 0
      t.integer :results_fine, default: 0
      t.integer :high5_total, default: 0
      t.integer :feedback_given, default: 0
      t.integer :comments, default: 0
      t.boolean :help_emails, default: true
      t.string :slack_token
      t.string :slack_team_id
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
