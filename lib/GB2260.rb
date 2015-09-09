require "GB2260/version"
require "GB2260/data"
require "GB2260/division"

class GB2260
  LATEST_YEAR = "2014".freeze

  def initialize(year=nil)
    @year = year || LATEST_YEAR
  end

  def get(code)
    Division.get(code, @year)
  end
end
