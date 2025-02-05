# frozen_string_literal: true

class CreateProjectEventHistories < ActiveRecord::Migration[7.1]
  def change
    create_table :project_event_histories do |t|
      t.references :project, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :event_type, null: false
      t.text :content
      t.timestamps
    end
  end
end
