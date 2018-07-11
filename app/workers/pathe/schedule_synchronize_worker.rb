require 'sidekiq'
require 'sidekiq-scheduler'

module Pathe
  class ScheduleSynchronizeWorker
    include Sidekiq::Worker

    def perform
      external_theater_ids  = Theater.pathe.pluck(:external_id)
      dates                 = Pathe::Schedule.dates

      dates.each do |date|
        schedule_hash = Crawlers::Pathe::ScheduleCrawler.crawl(external_theater_ids: external_theater_ids, date: date)

        Parsers::Pathe::ScheduleParser.parse(schedule_hash)
      end
    end
  end
end
