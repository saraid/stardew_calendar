def farm
  @farm ||= Farm.new(3, 7)
end

def plot_size
  8
end

# Row 1
farm[1, 1] do
  plant Crop::Wheat, on: Summer::Day01
  plant Crop::Wheat, on: Summer::Day05
  plant Crop::Wheat, on: Summer::Day09
  plant Crop::Wheat, on: Summer::Day13
  plant Crop::Wheat, on: Summer::Day17
  plant Crop::Wheat, on: Summer::Day21
  plant Crop::Wheat, on: Summer::Day25
end

farm[1, 2] do
  plant Crop::Wheat, on: Summer::Day01
  plant Crop::Wheat, on: Summer::Day05
  plant Crop::Wheat, on: Summer::Day09
  plant Crop::Wheat, on: Summer::Day13
  plant Crop::Wheat, on: Summer::Day17
  plant Crop::Wheat, on: Summer::Day21
  plant Crop::Wheat, on: Summer::Day25
end

farm[1, 3] do
  plant Crop::Radish, on: Summer::Day01
  plant Crop::Blueberry, on: Summer::Day07
end

farm[1, 4] do
  plant Crop::Radish, on: Summer::Day01
  plant Crop::Blueberry, on: Summer::Day07
end

farm[1, 5] do
  plant Crop::Blueberry, on: Summer::Day01
end

farm[1, 6] do
  plant Crop::Blueberry, on: Summer::Day01
end

farm[1, 7] do
  plant Crop::Blueberry, on: Summer::Day01
end

# Row 2
2.tap do |row|
  farm[row, 1] do
    plant Crop::SummerSpangle, on: Summer::Day01
    plant Crop::Melon, on: Summer::Day09
  end

  farm[row, 2] do
    plant Crop::Starfruit, on: Summer::Day01
    plant Crop::SummerSpangle, on: Summer::Day14
  end

  farm[row, 3] do
    plant Crop::Starfruit, on: Summer::Day01
    plant Crop::SummerSpangle, on: Summer::Day14
  end

  farm[row, 4] do
    plant Crop::HotPepper, on: Summer::Day01
  end

  farm[row, 5] do
    plant Crop::HotPepper, on: Summer::Day01
  end

  farm[row, 6] do
    plant Crop::Blueberry, on: Summer::Day01
  end

  farm[row, 7] do
    plant Crop::Blueberry, on: Summer::Day01
  end
end

# Row 3
3.tap do |row|
  farm[row, 1] do
    plant Crop::Tomato, on: Summer::Day01
  end

  farm[row, 2] do
    plant Crop::Tomato, on: Summer::Day01
  end

  farm[row, 3] do
    plant Crop::RedCabbage, on: Summer::Day01
    plant Crop::RedCabbage, on: Summer::Day10
  end

  farm[row, 4] do
    plant Crop::RedCabbage, on: Summer::Day01
    plant Crop::RedCabbage, on: Summer::Day10
  end

  farm[row, 5] do
    plant Crop::Poppy, on: Summer::Day01
    plant Crop::Poppy, on: Summer::Day08
    plant Crop::Melon, on: Summer::Day15
  end

  farm[row, 6] do
    plant Crop::Blueberry, on: Summer::Day01
  end

  farm[row, 7] do
    plant Crop::Blueberry, on: Summer::Day01
  end
end

