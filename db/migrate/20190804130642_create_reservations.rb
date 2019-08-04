class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.datetime :start
      t.integer :duration
      t.string :user
      t.references :table, foreign_key: true

      t.timestamps
    end
  end
end
