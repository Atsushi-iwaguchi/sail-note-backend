class CreateRaceResults < ActiveRecord::Migration[8.1]
  def change
    create_table :race_results do |t|
      t.references :tournament_entry, null: false, foreign_key: true
      t.integer :race_number, null: false
      t.integer :score, null: false
      t.timestamps
    end
  end
end
