class AddSexToStat < ActiveRecord::Migration[5.0]
  def change
    add_column :stats, :sex, :string
  end
end
