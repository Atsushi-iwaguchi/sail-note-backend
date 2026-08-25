FactoryBot.define do
  factory :practice_record do
    association :user

    practice_date { Date.current }
    wind_direction { "北" }
    min_wind_speed { 5 }
    max_wind_speed { 10 }
    tide { :oshio }
    mast_rake { 6550 }
    mast_bend { 30 }
    mast_spreader_angle { 720 }
    mast_spreader_length { 440 }
    mast_tension { 20 }
    content { "今日は風が強かった" }
    reflection { "タックのタイミングを改善したい" }
    weather { "晴れ" }
    temperature { 25.0 }
  end
end
