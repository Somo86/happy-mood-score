# frozen_string_literal: true

class CreateLanguages < ActiveRecord::Migration[6.1]
  def up
    create_table :languages do |t|
      t.string :uuid, limit: 36, null: false, index: true, unique: true
      t.string :name, limit: 50
      t.string :code, limit: 8
      t.timestamps
    end

    ::Language.create!(name: 'English', code: 'en')
    ::Language.create!(name: 'Español', code: 'es')
  end

  def down
    drop_table :languages
  end
end
