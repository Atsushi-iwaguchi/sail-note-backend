class CreatePracticeRecords < ActiveRecord::Migration[8.1]
  def change
    create_table :practice_records do |t|
      t.references :user, null: false, foreign_key: true

      t.date :practice_date, null: false

      t.string :wind_direction
      t.integer :min_wind_speed
      t.integer :max_wind_speed
      t.integer :tide
      t.integer :mast_rake
      t.integer :mast_bend
      t.integer :mast_spreader_angle
      t.integer :mast_spreader_length
      t.integer :mast_tension

      t.text :content
      t.text :reflection

      t.string :weather
      t.float :temperature

      t.timestamps
    end
  end
end
