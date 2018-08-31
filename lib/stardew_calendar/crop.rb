module StardewCalendar
  class Crop
    rattr_initialize :name, :seasons, :days_until_first_harvest, :days_until_regrowth

    def seasons
      Array(@seasons)
    end
    
    def custom_inspection
      to_s
    end

    def to_s
      name
    end

    BlueJazz = new('Blue Jazz', :Spring, 7, nil)
    Cauliflower = new('Cauliflower', :Spring, 12, nil)
    CoffeeBean = new('Coffee Bean', [:Spring, :Summer], 10, 2)
    Garlic = new('Garlic', :Spring, 4, nil)
    GreenBean = new('Green Bean', :Spring, 10, 3)
    Kale = new('Kale', :Spring, 6, nil)
    Parsnip = new('Parsnip', :Spring, 4, nil)
    Potato = new('Potato', :Spring, 6, nil)
    Rhubarb = new('Rhubarb', :Spring, 13, nil)
    Strawberry = new('Strawberry', :Spring, 8, 4)
    Tulip = new('Tulip', :Spring, 6, nil)
    Blueberry = new('Blueberry', :Summer, 13, 4)
    Corn = new('Corn', [:Summer, :Fall], 14, 4)
    Hops = new('Hops', :Summer, 11, 1)
    HotPepper = new('Hot Pepper', :Summer, 5, 3)
    Melon = new('Melon', :Summer, 12, nil)
    Poppy = new('Poppy', :Summer, 7, nil)
    Radish = new('Radish', :Summer, 6, nil)
    RedCabbage = new('Red Cabbage', :Summer, 9, nil)
    Starfruit = new('Starfruit', :Summer, 13, nil)
    SummerSpangle = new('Summer Spangle', :Summer, 8, nil)
    Sunflower = new('Sunflower', :Summer, 8, nil)
    Tomato = new('Tomato', :Summer, 11, 4)
    Wheat = new('Wheat', [:Summer, :Fall], 4, nil)
    Amaranth = new('Amaranth', :Fall, 7, nil)
    Artichoke = new('Artichoke', :Fall, 8, nil)
    Beet = new('Beet', :Fall, 6, nil)
    BokChoy = new('Bok Choy', :Fall, 4, nil)
    Cranberries = new('Cranberries', :Fall, 7, 5)
    Eggplant = new('Eggplant', :Fall, 5, 5)
    FairyRose = new('Fairy Rose', :Fall, 12, nil)
    Grape = new('Grape', :Fall, 10, 3)
    Pumpkin = new('Pumpkin', :Fall, 13, nil)
    Yam = new('Yam', :Fall, 10, nil)
    RareSeed = SweetGemBerry = new('Sweet Gem Berry', :Fall, 24, nil)
    AncientFruit = new('Ancient Fruit', [:Spring, :Summer, :Fall], 28, 7)

    def register_season!
      seasons.uniq.each do |season|
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
