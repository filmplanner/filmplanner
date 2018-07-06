FactoryBot.define do
  factory :show do
    movie     { build(:movie) }
    theater   { build(:theater) }
    date      { Time.zone.now }
    start_at  { Time.zone.now + 10.hours }
    end_at    { Time.zone.now + 12.hours }
    version   '3D'
    url       '/tickets/start/2635645'
  end
end
