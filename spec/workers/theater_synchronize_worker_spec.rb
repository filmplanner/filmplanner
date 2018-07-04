require 'rails_helper'

RSpec.describe TheaterSynchronizeWorker do
  describe '#perform' do
    before do
      expect(Crawlers::TheaterPathCrawler).to receive(:crawl) { ['/bioscoop/amersfoort'] }
    end

    subject(:worker) { TheaterSynchronizeWorker.new }

    it 'creates the correct records' do
      VCR.use_cassette 'crawlers/theater_response' do
        expect { worker.perform }.to change { Theater.count }.from(0).to(1)
      end
    end
  end
end
