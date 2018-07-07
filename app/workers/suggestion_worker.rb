require 'sidekiq'
require 'sidekiq-scheduler'

class SuggestionWorker
  include Sidekiq::Worker

  def perform(id)
    remaining_days = Pathe::Schedule.remaining_days

    (0..remaining_days).each do |i|
      date = Time.zone.today + i.days

      Filmplanner::Combination.combine(date, id)
    end
  end
end
