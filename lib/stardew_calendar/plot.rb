module StardewCalendar
  class Plot
    class Occupied < StandardError; end

    def initialize
      @schedule = Schedule.instance
      @farmable_days = Schedule.farmable_days
    end
    attr_reader :schedule

    def print_schedule
      tp(@farmable_days.map do |day|
        next if @schedule[day].empty?
        { day: day, crop: @schedule[day].map(&:to_s).join(', ') }
      end.compact)
    end

    def clear_plot(action)
      day = action.day

      @schedule[day] << action

      current_day_index = @farmable_days.index(day)
      @farmable_days[current_day_index..-1].each do |current_day|
        @schedule[current_day].reject! do |action|
          case action
          when Action::PlayerAction::Plant,
               Action::PlayerAction::Harvest,
               Action::GameEvent::Grow
            true
          else false
          end
        end
      end
    end

    def plant_crop(action)
      day, crop = action.day, action.crop

      raise Plot::Occupied if @schedule[day].any? do |action|
        Action::PlayerAction::Plant === action 
      end

      @schedule[day] << action

      test_for_season_change = lambda do |action|
        Action::GameEvent::SeasonChange === action &&
          !crop.seasons.include?(action.to_season)
      end

      day_cursor = day
      crop.days_until_first_harvest.times do |succ|
        day_actions = @schedule[day_cursor += 1]
        return if day_actions.any?(&test_for_season_change)

        day_actions << Action::GameEvent::Grow.new(self)
      end

      @schedule[day_cursor].delete_if { |action| Action::GameEvent::Grow === action }
      @schedule[day_cursor] << Action::PlayerAction::Harvest.new(crop, self)

      unless crop.days_until_regrowth.nil?
        loop do
          crop.days_until_regrowth.times do |succ|
            day_actions = @schedule[day_cursor += 1]
            return if day_actions.any?(&test_for_season_change)

            day_actions << Action::GameEvent::Grow.new(self)
          end
          @schedule[day_cursor] << Action::PlayerAction::Harvest.new(crop, self)
        end
      end
    end
  end
end
