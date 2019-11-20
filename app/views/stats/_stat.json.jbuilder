json.extract! stat, :id, :segment_id, :place, :name, :company, :time, :minkm, :kmh, :stars, :created_at, :updated_at
json.url stat_url(stat, format: :json)