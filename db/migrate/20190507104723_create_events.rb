class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.references :admin, index: true
      t.datetime :start_time
      t.integer :duration
      t.string :title
      t.text :description
      t.integer :price
      t.string :location
      t.timestamps
    end
  end
end
