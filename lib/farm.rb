load 'lib/stardew_calendar/plot/dsl.rb'

class Farm
  def initialize(rows, cols)
    @plots =
      Array.new(rows).map do
        Array.new(cols).map do
          Plot.new.tap(&:apply_dsl!)
        end
      end
  end

  def [](row, col, &block)
    row -= 1
    col -= 1

    raise RangeError if row.to_i < 0 || col.to_i < 0
    raise RangeError if row.to_i >= @plots.size || col.to_i >= @plots.first.size

    @plots[row][col].tap do |plot|
      plot.instance_exec(&block) if block_given?
    end
  end

  def plots
    @plots.flatten
  end

  def on_day(day)
    @plots.map.with_index do |p_col, row|
      p_col.map.with_index do |plot, col|
        plot.schedule[day].map(&:to_s).join(', ')
      end
    end
  end

  def first_empty_day(starting)
    Schedule.farmable_days.find do |day|
      next unless day > starting
      plots.
        map(&:schedule).
        map { |schedule| schedule[day].map(&:to_s) }.
        any? { |actions| actions.empty? }
    end
  end

  def all_harvests
    plots.map(&:schedule).map(&:values).flatten.select do |action|
      StardewCalendar::Action::PlayerAction::Harvest === action
    end.
      group_by { |harvest| harvest.crop }.
      transform_keys(&:to_s).
      transform_values(&:size)
  end
end
