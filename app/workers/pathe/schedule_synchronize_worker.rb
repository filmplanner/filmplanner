require 'sidekiq'
require 'sidekiq-scheduler'

module Pathe
  class ScheduleSynchronizeWorker
    include Sidekiq::Worker

    def perform
      external_theater_ids  = Theater.pathe.pluck(:external_id)
      remaining_days        = Pathe::Schedule.remaining_days

      (0..remaining_days).each do |i|
        date          = Time.zone.today + i.days
        schedule_hash = Crawlers::Pathe::ScheduleCrawler.crawl(external_theater_ids: external_theater_ids, date: date)

        Parsers::Pathe::ScheduleParser.parse(schedule_hash)
      end
    end
  end
end
