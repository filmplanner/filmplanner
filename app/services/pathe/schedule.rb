# Pathe.nl updates it's schedule every week
# on a Monday. This update contains a schedule for the
# upcoming Thursday till Wednesday.

module Pathe
  class Schedule
    class << self
      MONDAY    = 1
      THURSDAY  = 4

      def today
        Time.zone.today
      end

      def last_updated
        difference = MONDAY - weekday(today)

        today + difference.days
      end

      def update_start
        difference = THURSDAY - weekday(last_updated)

        last_updated + difference.days
      end

      def update_end
        update_start + 6.days
      end

      def remaining_days
        ((update_end - today).days / 1.day).to_i
      end

      def weekday(date)
        # Algoritm needs to see Sunday as 7th weekday,
        # otherwise it won't calculate the right dates.
        date.wday == 0 ? 7 : date.wday
      end
    end
  end
end
