module StardewCalendar
  class Schedule
    def self.instance
      day_array.
        zip(Array.new(84).map { [] }).to_h.tap do |hash|
        hash[Season::Spring::Day01] << Action::GameEvent::SeasonChange.new(:Spring)
        hash[Season::Summer::Day01] << Action::GameEvent::SeasonChange.new(:Summer)
        hash[Season::Fall::Day01]   << Action::GameEvent::SeasonChange.new(:Fall)
      end
    end

    def self.day_array
      Season::Spring.days + Season::Summer.days + Season::Fall.days
    end

    class Day
      def initialize(season, day)
        @season, @day = season, day
      end

      def to_s
        "#{@season.to_s} #{@day.to_s}"
      end
    end

    class Season < Module
      def initialize(name)
        @name = name
      end

      def to_s
        @name
      end

      def days
        constants.map(&method(:const_get)).select { |klass| Day === klass }
      end

      def with_days
        28.times.each do |index|
          const_set(:"Day#{"%02d" % (index+1)}", Day.new(self, index + 1))
        end
        self
      end

      def register_crop(crop)
        (@crops ||= []) << crop
      end
      attr_reader :crops

      Spring = new(:Spring).with_days
      Summer = new(:Summer).with_days
      Fall   = new(:Fall).with_days
    end
  end
end
