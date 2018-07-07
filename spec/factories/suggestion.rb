FactoryBot.define do
  factory :suggestion do
    date      { Time.zone.now }
    start_at  { Time.zone.now + 10.hours }
    end_at    { Time.zone.now + 12.hours }
  end
end
