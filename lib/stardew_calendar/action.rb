module StardewCalendar
  class Action
    def execute!; end
    def to_s
      self.class.name.split('::')[-1]
    end

    class PlayerAction < Action
      class Plant < PlayerAction
        rattr_initialize :crop, :plot, :day

        def to_s
          "Plant #{crop}"
        end

        def execute!
          plot.plant(self)
        end
      end

      class Harvest < PlayerAction
        rattr_initialize :crop, :plot

        def to_s
          "Harvest #{crop}"
        end
      end

      class Clear < PlayerAction
        rattr_initialize :plot, :day

        def execute!
          plot.clear(self)
        end
      end
    end

    class GameEvent < Action
      class Grow < GameEvent
        rattr_initialize :plot
      end

      class SeasonChange < GameEvent
        rattr_initialize :to_season
      end
    end
  end
end
