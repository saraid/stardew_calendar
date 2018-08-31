module StardewCalendar
  class Schedule
    def self.instance
      farmable_days.
        zip(Array.new(84).map { [] }).to_h.tap do |hash|
        hash[Season::Spring::Day01] << Action::GameEvent::SeasonChange.new(:Spring)
        hash[Season::Summer::Day01] << Action::GameEvent::SeasonChange.new(:Summer)
        hash[Season::Fall::Day01]   << Action::GameEvent::SeasonChange.new(:Fall)
      end
    end

    def self.farmable_days
      Season::Spring.days + Season::Summer.days + Season::Fall.days
    end

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

    class Season < Module
      include Comparable
      PROGRESSION = %i(Spring Summer Fall Winter)

      def initialize(name)
        @name = name

        28.times.each do |index|
          const_set(:"Day#{"%02d" % (index+1)}", Day.new(self, index + 1))
        end
      end

      def <=>(other)
        PROGRESSION.index(@name) <=>
          PROGRESSION.index(other.instance_variable_get(:@name))
      end

      def custom_inspection
        @name.to_s
      end

      def prev
        @prev ||= Season.const_get(
          PROGRESSION.reverse.
            lazy.cycle.drop_while { |name| name != @name }.drop(1).first.to_sym)
      end

      def succ
        @succ ||= Season.const_get(
          PROGRESSION.
            lazy.cycle.drop_while { |name| name != @name }.drop(1).first.to_sym)
      end

      def to_s
        @name.to_s
      end

      def days
        constants.map(&method(:const_get)).select { |klass| Day === klass }.sort
      end

      def register_crop(crop)
        (@crops ||= []) << crop
      end
      attr_reader :crops

      Spring = new(:Spring)
      Summer = new(:Summer)
      Fall   = new(:Fall)
      Winter = new(:Winter)
    end
  end
end
