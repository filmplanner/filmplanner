require 'sidekiq'
require 'sidekiq-scheduler'

class TheaterSynchronizeWorker
  include Sidekiq::Worker

  def perform
    theater_path_hash = Crawlers::Pathe::TheaterPathCrawler.crawl

    theater_path_hash[:paths].each do |path|
      theater_hash = Crawlers::Pathe::TheaterCrawler.crawl(path: path)

      Parsers::TheaterParser.parse(theater_hash)
    end
  end
end
