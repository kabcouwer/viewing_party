class CreateParties < ActiveRecord::Migration[5.2]
  def change
    create_table :parties do |t|
      t.string :movie_title
      t.integer :duration
      t.datetime :day
      t.datetime :start_time

      t.timestamps
    end
  end
end
