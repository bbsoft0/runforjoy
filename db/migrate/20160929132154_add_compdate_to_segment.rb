class AddCompdateToSegment < ActiveRecord::Migration[5.0]
  def change
    add_column :segments, :compdate, :date
  end
end
