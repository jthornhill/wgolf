class CreateRoundsUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :rounds_users do |t|
      t.references :round, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
