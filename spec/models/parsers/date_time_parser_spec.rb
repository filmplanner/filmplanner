require 'rails_helper'

module Parsers
  RSpec.describe DateTimeParser do
    describe '#parse' do
      let(:date) { Date.new(2017, 2, 3) }
      let(:time) { '12:30' }

      subject(:parser) { DateTimeParser.new(date, time) }

      it 'returns the correct datetime' do
        expect(parser.parse).to eq Time.zone.local(2017, 2, 3, 12, 30, 0)
      end
    end
  end
end
