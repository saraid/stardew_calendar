module StardewCalendar
  class Plot
    class Occupied < StandardError; end

    def initialize
      @schedule = Schedule.instance
      @schedule_array = Schedule.day_array
    end
    attr_reader :schedule

    def print_schedule
      tp(@schedule_array.map do |day|
        next if @schedule[day].empty?
        { day: day, crop: @schedule[day].map(&:to_s).join(', ') }
      end.compact)
    end

    def clear(action)
      day = action.day

      @schedule[day] << action

      current_day_index = @schedule_array.index(day)
      @schedule_array[current_day_index..-1].each do |current_day|
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

    def plant(action)
      day, crop = action.day, action.crop

      raise Plot::Occupied if @schedule[day].any? do |action|
        Action::PlayerAction::Plant === action 
      end

      @schedule[day] << action

      test_for_season_change = lambda do |action|
        Action::GameEvent::SeasonChange === action &&
          !crop.seasons.include?(action.to_season)
      end

      current_day_index = @schedule_array.index(day)
      crop.days_until_first_harvest.times do |succ|
        current_day = @schedule[@schedule_array[current_day_index + succ + 1]]
        return if current_day.any?(&test_for_season_change)

        current_day << Action::GameEvent::Grow.new(self)
      end

      current_day_index += crop.days_until_first_harvest
      @schedule[@schedule_array[current_day_index]] <<
        Action::PlayerAction::Harvest.new(crop, self)

      unless crop.days_until_regrowth.nil?
        loop do
          crop.days_until_regrowth.times do |succ|
            current_day = @schedule[@schedule_array[current_day_index + succ + 1]]
            return if current_day.any?(&test_for_season_change)

            current_day << Action::GameEvent::Grow.new(self)
          end
          current_day_index += crop.days_until_regrowth
          @schedule[@schedule_array[current_day_index]] <<
            Action::PlayerAction::Harvest.new(crop, self)
        end
      end
    end
  end
end
