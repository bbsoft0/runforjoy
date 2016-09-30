module Utils
  require 'time'


    # totaltime to seconds
  def self.getSeconds(totaltime)

      #getting seconds per km
      m = Time.parse('00:00')
      tTime=Time.parse(totaltime)
      tTime.to_i - m.to_i
  end

    # Pace - from total time (ex 3:45) to (1:25/km)
  def self.getPace(distance, totaltime)
      dis_pace = distance.to_f

      #getting seconds per km
      m = Time.parse('00:00')
      tTime=Time.parse(totaltime)
      seconds = (tTime.to_i - m.to_i)
      pace = seconds / dis_pace

      #getting minutes from pace
      min = (pace.to_f / 60)

      #getting remaining seconds
      sec = pace % 60

      min.to_f.floor.to_s + ":" + sec.to_f.floor.to_s.rjust(2, '0')
  end

#DistanceKm * ((FinishHour + FinMin) - (StartHour + StartMin)), " km/h"
  def self.getKmh(distance, totaltime)
      dis_pace = distance.to_f

      m = Time.parse('00:00')
      tTime=Time.parse(totaltime)
      seconds = (tTime.to_i - m.to_i)
      kmh = dis_pace *3600/ seconds
      sprintf('%.2f', kmh)
  end


def self.getLevel(distance, totaltime)
      dis_pace = distance.to_f

      #getting seconds per km
      m = Time.parse('00:00')
      tTime=Time.parse(totaltime)
      seconds = (tTime.to_i - m.to_i)
      pace = seconds / dis_pace

      level=0
      case pace
          when 390..420
              level=1
          when 360..390
              level=2
          when 330..360
              level=3
          when 300..330
              level=4
          when 270..300
              level=5
          when 240..270
              level=6
          when 210..240
              level=7
          when 0..210
              level=8
      end

      level
end

end
