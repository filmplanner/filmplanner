require 'sidekiq'
require 'sidekiq-scheduler'

module Pathe
  class ScheduleSynchronizeWorker
    include Sidekiq::Worker

    def perform
      theater_ids     = Theater.pathe.pluck(:id)
      remaining_days  = Pathe::Schedule.remaining_days

      (0..remaining_days).each do |i|
        date          = Time.zone.today + i.days
        schedule_hash = Crawlers::Pathe::ScheduleCrawler.crawl(theater_ids: theater_ids, date: date)

        Parsers::Pathe::ScheduleParser.parse(schedule_hash)
      end
    end
  end
end
