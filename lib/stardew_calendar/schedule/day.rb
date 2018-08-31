module StardewCalendar
  class Schedule
    class Day
      include Comparable

      def initialize(season, day)
        @season, @day = season, day
      end
      attr_reader :season, :day

      def <=>(other)
        [ season,  day ] <=> [ other.season, other.day ]
      end

      def custom_inspection
        to_s
      end

      def prev
        if day == 1
          season.prev::Day28
        else
          season.const_get(:"Day#{'%02d' % (day-1)}")
        end
      end

      def succ
        if day == 28
          season.succ::Day01
        else
          season.const_get(:"Day#{'%02d' % day.succ}")
        end
      end

      def +(num)
        num.times.inject(self) { |memo, _| memo.succ }
      end

      def -(num)
        num.times.inject(self) { |memo, _| memo.prev }
      end

      def to_s
        "#{@season.to_s} #{@day.to_s}"
      end
    end
  end
end
