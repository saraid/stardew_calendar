require 'attr_extras'
require 'table_print'

require_relative 'stardew_calendar/action'
require_relative 'stardew_calendar/plot'
require_relative 'stardew_calendar/schedule'
require_relative 'stardew_calendar/crop'

module StardewCalendar
  def self.export_constants
    [ Action::PlayerAction::Plant,
      Action::PlayerAction::Clear,
      Crop, Plot, Schedule,
      Schedule::Season::Spring,
      Schedule::Season::Summer,
      Schedule::Season::Fall,
      Schedule::Season::Winter,
    ].each do |klass|
      sym = klass.name.split('::').last.to_sym
      if Kernel.const_defined?(sym)
        raise "Collision on #{sym}" unless Kernel.const_get(sym) == klass
      else
        Kernel.const_set(sym, klass)
      end
    end
  end
end

require 'highline/system_extensions'
set_max_width = proc do
  cols, rows = HighLine::SystemExtensions.terminal_size
  tp.set :max_width, cols
end

set_max_width.call
Signal.trap('SIGWINCH', set_max_width)
