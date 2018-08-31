class Farm
  def initialize(rows, cols)
    @plots =
      Array.new(rows).map do
        Array.new(cols).map do
          Plot.new.tap do |plot|
            plot.singleton_class.class_eval do
              def plant(crop, on:)
                Plant.new(crop, self, on).execute!
              end
            end
          end
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
    Schedule.day_array.find do |day|
      next unless day > starting
      plots.
        map(&:schedule).
        map { |schedule| schedule[day].map(&:to_s) }.
        any? { |actions| actions.empty? }
    end
  end

  def all_harvests
    plots.map(&:schedule).map(&:values).flatten.select do |actions|
      StardewCalendar::Action::PlayerAction::Harvest === actions
    end.group_by { |action| action.crop }.map do |crop, actions|
      [ crop.to_s, actions.size ]
    end.to_h
  end
end
