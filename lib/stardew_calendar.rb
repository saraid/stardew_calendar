require 'attr_extras'
require 'table_print'

require_relative 'stardew_calendar/action'
require_relative 'stardew_calendar/plot'
require_relative 'stardew_calendar/schedule'
require_relative 'stardew_calendar/crop'

module StardewCalendar
  class Plan
    rattr_initialize :farm
  end

  class Farm
    rattr_initialize :plots
  end
end

require 'highline/system_extensions'
set_max_width = proc do
  cols, rows = HighLine::SystemExtensions.terminal_size
  tp.set :max_width, cols
end

set_max_width.call
Signal.trap('SIGWINCH', set_max_width)
