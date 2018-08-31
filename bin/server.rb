require 'sinatra'

load 'lib/stardew_calendar.rb'

module StardewCalendar
  class Crop
    def self.find(name)
      Crop.constants.map(&Crop.method(:const_get)).find do |crop|
        crop.name == name
      end
    end
  end

  class Schedule::Season
    def self.find(name)
      [Spring, Summer, Fall, Winter].find do |season|
        season.name.downcase.include? name
      end
    end
  end

  class Schedule::Day
    def self.parse(text)
      text.match(/(?<season>Spring|Summer|Fall|Winter) (?<day>\d+)/).
        yield_self do |match_data|
          Season.find(match_data[:season].downcase).
            const_get(:"Day#{'%02d' % match_data[:day].to_i}")
        end
    end
  end
end

StardewCalendar.export_constants
Season = StardewCalendar::Schedule::Season
Day = StardewCalendar::Schedule::Day

before do
  content_type 'text/json'
  headers 'X-Source-Code-At' => 'https://github.com/saraid/stardew_calendar'
end

get '/can_be_planted_today' do
  season = Season.find(params[:season])
  remaining_days = params.fetch(:remaining_days) { 28 - params[:day].to_i }.to_i

  season.crops.
    select { |crop| crop.days_until_first_harvest <= remaining_days }.
    map { |crop| [ crop.to_s, crop.days_until_first_harvest ] }.
    to_h.
    to_json
end

post '/harvest_schedule' do
  plot = Plot.new

  JSON.parse(request.body.read, symbolize_names: true)[:schedule].each do |action|
    case action[:action]
    when 'plant'
      Plant.new(Crop.find(action[:crop]), plot, Day.parse(action[:day]))
    when 'clear'
      Clear.new(plot, Day.parse(action[:day]))
    end.yield_self do |action|
      action.execute! unless action.nil?
    end
  end

  schedule = plot.schedule
  Schedule.farmable_days.
    map { |day| [ day.to_s, plot.schedule[day].map(&:to_s) ] }.
    delete_if { |k, v| v.empty? }.
    to_h.
    to_json
end
