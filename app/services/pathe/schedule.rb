# Pathe.nl updates it's schedule every week
# on a Monday. This update contains a schedule for the
# upcoming Thursday till Wednesday.

module Pathe
  class Schedule
    class << self
      def today
        Time.zone.today
      end

      def update_start
        difference = end_weekday - weekday(last_updated)

        last_updated + difference.days
      end

      def update_end
        update_start + days_to_update.days
      end

      def last_updated
        difference = weekday(today) - start_weekday

        today - difference.days
      end

      def remaining_days
        ((update_end - today).days / 1.day).to_i
      end

      def days_to_update
        6
      end

      def start_weekday
        1 # Monday
      end

      def end_weekday
        4 # Thursday
      end

      def weekday(date)
        date.wday == 0 ? 7 : date.wday
      end
    end
  end
end
