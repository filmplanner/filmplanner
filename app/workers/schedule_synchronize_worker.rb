require 'sidekiq'
require 'sidekiq-scheduler'

class ScheduleSynchronizeWorker
  include Sidekiq::Worker

  def perform
    theater_ids     = Theater.all.pluck(:id).join(',')
    remaining_days  = Pathe::Schedule.remaining_days

    (0..remaining_days).each do |days|
      schedule_hash = Crawlers::ScheduleCrawler.crawl("/update-schedule/#{theater_ids}/#{days_from_today(days)}")

      Parsers::ScheduleParser.parse(schedule_hash)
    end
  end

  private

  def days_from_today(days)
    (Time.zone.today + days.days).strftime('%d-%m-%Y')
  end
end
