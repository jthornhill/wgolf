class CreateWordles < ActiveRecord::Migration[7.0]
  def change
    create_table :wordles do |t|
      t.integer :game_number, unique: true
      t.string :answer

      t.timestamps
    end
  end
end
