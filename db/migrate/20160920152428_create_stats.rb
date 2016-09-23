class CreateStats < ActiveRecord::Migration[5.0]
  def change
    create_table :stats do |t|
      t.integer :segment_id
      t.integer :place
      t.string :name
      t.string :company
      t.string :time
      t.string :minkm
      t.string :kmh
      t.integer :stars

      t.timestamps
    end
  end
end
