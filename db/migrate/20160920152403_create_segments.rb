class CreateSegments < ActiveRecord::Migration[5.0]
  def change
    create_table :segments do |t|
      t.string :name
      t.decimal :dist
      t.string :pr
      t.string :goal

      t.timestamps
    end
  end
end
