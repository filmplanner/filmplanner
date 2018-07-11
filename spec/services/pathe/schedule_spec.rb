require 'rails_helper'

module Pathe
  RSpec.describe Schedule do
    (0..6).each do |i|
      context "when wday is #{i}" do
        let(:today) { Date.new(2018, 7, 2) + i.days }
        let(:remaining_days) { 9 - i }

        before do
          Timecop.freeze(today)
        end

        describe '.today' do
          it 'returns the correct date' do
            expect(Schedule.today).to eq today
          end
        end

        describe '.last_updated' do
          it 'returns the correct date' do
            expect(Schedule.last_updated).to eq Date.new(2018, 7, 2)
          end
        end

        describe '.remaining_days' do
          it 'returns the correct days' do
            expect(Schedule.remaining_days).to eq remaining_days
          end
        end

        describe '.update_start' do
          it 'returns the correct date' do
            expect(Schedule.update_start).to eq Date.new(2018, 7, 5)
          end
        end

        describe '.update_end' do
          it 'returns the correct date' do
            expect(Schedule.update_end).to eq Date.new(2018, 7, 11)
          end
        end

        describe '.dates' do
          it 'returns the correct dates' do
            expect(Schedule.dates.size).to eq remaining_days + 1
            expect(Schedule.dates.first).to eq today
          end
        end
      end
    end
  end
end
