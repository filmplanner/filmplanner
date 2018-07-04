require 'sidekiq'
require 'sidekiq-scheduler'

class TheaterSynchronizeWorker
  include Sidekiq::Worker

  def perform
    theater_paths = Crawlers::TheaterPathCrawler.crawl

    theater_paths.each do |path|
      theater_hash = Crawlers::TheaterCrawler.crawl(path)

      Parsers::TheaterParser.parse(theater_hash)
    end
  end
end
