require 'sidekiq'
require 'sidekiq-scheduler'

class SuggestionScheduleWorker
  include Sidekiq::Worker

  def perform
    Theater.all.each do |theater|
      SuggestionWorker.perform_async(theater.id)
    end
  end
end
