class CreateMonthlyGoals < ActiveRecord::Migration[8.1]
  def change
    create_table :monthly_goals do |t|
      t.references :user, null: false, foreign_key: true
      t.date :goal_date, null: false
      t.text :content, null: false
      t.integer :achievement_rate

      t.timestamps
    end
  end
end
