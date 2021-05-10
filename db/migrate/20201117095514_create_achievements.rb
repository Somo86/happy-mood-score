# frozen_string_literal: true

class CreateAchievements < ActiveRecord::Migration[6.0]
  def change
    create_table :achievements do |t|
      t.string :uuid, limit: 36, null: false, index: true, unique: true
      t.references :employee
      t.references :reward
      t.timestamps
    end

    add_index :achievements, %i[employee_id reward_id]
  end
end
