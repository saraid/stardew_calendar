module StardewCalendar
  class Schedule
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

    end
  end
end
