class CreateResultSubmissions < ActiveRecord::Migration[7.0]
  def change
    create_table :result_submissions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :wordle, null: false, foreign_key: true
      t.text :share_text
      t.index [:user_id, :wordle_id], unique: true

      t.timestamps
    end
  end
end
