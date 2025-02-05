# frozen_string_literal: true

class CreateProjects < ActiveRecord::Migration[7.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :description
      t.integer :status, default: 0
      t.references :owner, null: false, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
