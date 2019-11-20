class Stat < ApplicationRecord
  require 'Utils'
  require 'csv'
  require 'database_cleaner'

  belongs_to :segment,  :dependent => :delete

  def self.import(file, distance, segment_id)
    filename ||=file.path
    csv_text = File.read(filename)
    csv = CSV.parse(csv_text, :headers => true)
        Stat.where(:segment_id => segment_id).delete_all
        #Used only for reseting ids
        # DatabaseCleaner.clean_with(:truncation, :only => %w[])

          i = 0
          csv.each do |row|
            i = i + 1
            stat_row=Stat.new
            stat_row.place=i
            stat_row.segment_id=segment_id
            stat_row.name=row["name"].lstrip
            stat_row.company=row["company"].lstrip if row["company"]
            if row["category"]
              stat_row.sex=row["category"].lstrip[0]
            end
            stat_row.time=row["time"]
            stat_row.minkm=Utils.getPace(distance, row["time"])
            stat_row.kmh=Utils.getKmh(distance, row["time"])
            stat_row.stars=Utils.getLevel(distance, row["time"])
            stat_row.save!
          end
  end



end
