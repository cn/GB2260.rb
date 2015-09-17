require "GB2260/version"
require "GB2260/constants"
require "GB2260/data"
require "GB2260/division"

class GB2260
  def initialize(year=nil)
    @year = (year || LATEST_YEAR).to_s
  end

  def get(code)
    Division.get(code, @year)
  end

  def all_code
    Data.data[@year].keys
  end

  def provinces
    Division.batch all_code.select_end_with(PROVINCE_SUFFIX), @year
  end

  def prefectures(province_code)
    Division.batch(all_code
      .select_start_with(province_code.to_s[0,2])
      .select_end_with(PREFECTURE_SUFFIX)
      .reject_end_with(PROVINCE_SUFFIX),
    @year)
  end

  def counties(prefecture_code)
    Division.batch(all_code
      .select_start_with(prefecture_code.to_s[0,4])
      .reject_end_with(PREFECTURE_SUFFIX),
    @year)
  end
end
