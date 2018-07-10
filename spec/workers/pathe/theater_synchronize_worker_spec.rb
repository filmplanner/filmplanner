require 'rails_helper'

module Pathe
  RSpec.describe TheaterSynchronizeWorker do
    describe '#perform' do
      before do
        expect(Crawlers::Pathe::TheaterPathCrawler).to receive(:crawl) { { paths: ['/bioscoop/amersfoort'] } }
      end

      subject(:worker) { TheaterSynchronizeWorker.new }

      it 'creates the correct records' do
        VCR.use_cassette 'crawlers/pathe/theater_response' do
          expect { worker.perform }.to change { Theater.count }.from(0).to(1)
        end
      end
    end
  end
end
