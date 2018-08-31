def farm
  @farm ||= Farm.new(3, 7)
end

def plot_size
  8
end

# Row 1
farm[1, 1].instance_eval do |plot|
  [ Plant.new(Crop::Wheat, plot, Summer::Day01),
    Plant.new(Crop::Wheat, plot, Summer::Day05),
    Plant.new(Crop::Wheat, plot, Summer::Day09),
    Plant.new(Crop::Wheat, plot, Summer::Day13),
    Plant.new(Crop::Wheat, plot, Summer::Day17),
    Plant.new(Crop::Wheat, plot, Summer::Day21),
    Plant.new(Crop::Wheat, plot, Summer::Day25),
  ].each(&:execute!)
end

farm[1, 2].instance_eval do |plot|
  [ Plant.new(Crop::Wheat, plot, Summer::Day01),
    Plant.new(Crop::Wheat, plot, Summer::Day05),
    Plant.new(Crop::Wheat, plot, Summer::Day09),
    Plant.new(Crop::Wheat, plot, Summer::Day13),
    Plant.new(Crop::Wheat, plot, Summer::Day17),
    Plant.new(Crop::Wheat, plot, Summer::Day21),
    Plant.new(Crop::Wheat, plot, Summer::Day25),
  ].each(&:execute!)
end

farm[1, 3].instance_eval do |plot|
  [ Plant.new(Crop::Radish, plot, Summer::Day01),
    Plant.new(Crop::Blueberry, plot, Summer::Day07),
  ].each(&:execute!)
end

farm[1, 4].instance_eval do |plot|
  [ Plant.new(Crop::Radish, plot, Summer::Day01),
    Plant.new(Crop::Blueberry, plot, Summer::Day07),
  ].each(&:execute!)
end

farm[1, 5].instance_eval do |plot|
  [ Plant.new(Crop::Blueberry, plot, Summer::Day01),
  ].each(&:execute!)
end

farm[1, 6].instance_eval do |plot|
  [ Plant.new(Crop::Blueberry, plot, Summer::Day01),
  ].each(&:execute!)
end

farm[1, 7].instance_eval do |plot|
  [ Plant.new(Crop::Blueberry, plot, Summer::Day01),
  ].each(&:execute!)
end

# Row 2
2.tap do |row|
  farm[row, 1].instance_eval do |plot|
    [ Plant.new(Crop::SummerSpangle, plot, Summer::Day01),
      Plant.new(Crop::Melon, plot, Summer::Day09),
    ].each(&:execute!)
  end

  farm[row, 2].instance_eval do |plot|
    [ Plant.new(Crop::Starfruit, plot, Summer::Day01),
      Plant.new(Crop::SummerSpangle, plot, Summer::Day14),
    ].each(&:execute!)
  end

  farm[row, 3].instance_eval do |plot|
    [ Plant.new(Crop::Starfruit, plot, Summer::Day01),
      Plant.new(Crop::SummerSpangle, plot, Summer::Day14),
    ].each(&:execute!)
  end

  farm[row, 4].instance_eval do |plot|
    [ Plant.new(Crop::HotPepper, plot, Summer::Day01),
    ].each(&:execute!)
  end

  farm[row, 5].instance_eval do |plot|
    [ Plant.new(Crop::HotPepper, plot, Summer::Day01),
    ].each(&:execute!)
  end

  farm[row, 6].instance_eval do |plot|
    [ Plant.new(Crop::Blueberry, plot, Summer::Day01),
    ].each(&:execute!)
  end

  farm[row, 7].instance_eval do |plot|
    [ Plant.new(Crop::Blueberry, plot, Summer::Day01),
    ].each(&:execute!)
  end
end

# Row 3
3.tap do |row|
  farm[row, 1].instance_eval do |plot|
    [ Plant.new(Crop::Tomato, plot, Summer::Day01),
    ].each(&:execute!)
  end

  farm[row, 2].instance_eval do |plot|
    [ Plant.new(Crop::Tomato, plot, Summer::Day01),
    ].each(&:execute!)
  end

  farm[row, 3].instance_eval do |plot|
    [ Plant.new(Crop::RedCabbage, plot, Summer::Day01),
      Plant.new(Crop::RedCabbage, plot, Summer::Day10),
    ].each(&:execute!)
  end

  farm[row, 4].instance_eval do |plot|
    [ Plant.new(Crop::RedCabbage, plot, Summer::Day01),
      Plant.new(Crop::RedCabbage, plot, Summer::Day10),
    ].each(&:execute!)
  end

  farm[row, 5].instance_eval do |plot|
    [ Plant.new(Crop::Poppy, plot, Summer::Day01),
      Plant.new(Crop::Poppy, plot, Summer::Day08),
      Plant.new(Crop::Melon, plot, Summer::Day15),
    ].each(&:execute!)
  end

  farm[row, 6].instance_eval do |plot|
    [ Plant.new(Crop::Blueberry, plot, Summer::Day01),
    ].each(&:execute!)
  end

  farm[row, 7].instance_eval do |plot|
    [ Plant.new(Crop::Blueberry, plot, Summer::Day01),
    ].each(&:execute!)
  end
end

