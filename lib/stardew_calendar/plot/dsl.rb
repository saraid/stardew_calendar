module StardewCalendar
  class Plot
    def apply_dsl!
      StardewCalendar.export_constants

      singleton_class.class_eval do
        include Plot::DSL
      end
    end

    module DSL
      def clear(day)
        Clear.new(self, day).execute!
      end

      def plant(crop, on:)
        Plant.new(crop, self, on).execute!
      end
    end
  end
end
