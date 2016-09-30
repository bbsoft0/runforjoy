class RemovePrFromSegment < ActiveRecord::Migration[5.0]
  def change
    remove_column :segments, :pr, :string
  end
end
