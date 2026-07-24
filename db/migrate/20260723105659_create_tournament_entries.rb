class CreateTournamentEntries < ActiveRecord::Migration[8.1]
  def change
    create_table :tournament_entries do |t|
      t.references :tournament, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :overall_ranking, null: false
      t.text :reflection

      t.timestamps
    end
  end
end
