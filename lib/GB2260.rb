require "GB2260/version"
require "GB2260/constants"
require "GB2260/data"
require "GB2260/division"

class GB2260
  def initialize(year=nil)
    @year = year || LATEST_YEAR
  end

  def get(code)
    Division.get(code, @year)
  end

  def provinces
    Data.data[@year].keys
      .select { |c| c.end_with? PROVINCE_SUFFIX  }
      .map { |c| Division.get(c, @year) }
  end

  def prefectures(province_code)
    Data.data[@year].keys
      .select { |c| c.start_with? province_code.to_s[0,2] }
      .select { |c| c.end_with? PREFECTURE_SUFFIX  }
      .reject { |c| c.end_with? PROVINCE_SUFFIX }
      .map { |c| Division.get(c, @year) }
  end

  def counties(prefecture_code)
    Data.data[@year].keys
      .select { |c| c.start_with? prefecture_code.to_s[0,4] }
      .reject { |c| c.end_with? PREFECTURE_SUFFIX }
      .map { |c| Division.get(c, @year) }
  end
end
