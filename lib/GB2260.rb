require "GB2260/version"
require "GB2260/data"
require "GB2260/division"

class GB2260
  LATEST_YEAR = '2014'.freeze

  def initialize(year=nil)
    @year = year || LATEST_YEAR
  end

  def get(code)
    Division.get(code, @year)
  end

  def provinces
    Data.data[@year].keys
      .select { |c| c.end_with? '0000'.freeze }
      .map { |c| Division.get(c, @year) }
  end

  def prefectures(province_code)
    Data.data[@year].keys
      .select { |c| c.start_with? province_code.to_s[0,2] }
      .select { |c| c.end_with? '00'.freeze }
      .reject { |c| c.end_with? '0000'.freeze }
      .map { |c| Division.get(c, @year) }
  end
end
