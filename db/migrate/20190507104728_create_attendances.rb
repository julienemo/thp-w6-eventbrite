class CreateAttendances < ActiveRecord::Migration[5.2]
  def change
    create_table :attendances do |t|
      t.references :event, foreign_key: true
      t.references :participant, index: true
      t.string :stripe_customer_id
      t.timestamps
    end
  end
end
