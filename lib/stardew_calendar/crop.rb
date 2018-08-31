module StardewCalendar
  class Crop
    rattr_initialize :name, :seasons, :days_until_first_harvest, :days_until_regrowth

    def seasons
      Array(@seasons)
    end

    def to_s
      name
    end

    CoffeeBean = new('Coffee Bean', [:Spring, :Summer], 10, 2)
    Blueberry = new('Blueberry', :Summer, 13, 4)
    SummerSpangle = new('Summer Spangle', :Summer, 8, nil)

    def register_season!
      Array(@seasons).uniq.each do |season|
        case season
        when :Spring then Schedule::Season::Spring
        when :Summer then Schedule::Season::Summer
        when :Fall   then Schedule::Season::Fall
        end.register_crop(self)
      end
    end
    constants.map(&method(:const_get)).each(&:register_season!)
  end
end
