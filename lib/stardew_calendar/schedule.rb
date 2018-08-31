require_relative 'schedule/day'
require_relative 'schedule/season'

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

    Season::Spring = Season.new(:Spring)
    Season::Summer = Season.new(:Summer)
    Season::Fall   = Season.new(:Fall)
    Season::Winter = Season.new(:Winter)
  end
end
