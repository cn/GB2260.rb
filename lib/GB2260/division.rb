class GB2260
  class Division
    attr_reader :code, :name, :year

    def self.get(code, year=nil)
      new(code, Data.search(code, year))
    end

    def initialize(code, name, year=nil)
      @code = code.to_s
      @name = name.to_s
      @year = year
    end

    def ==(other)
      code == other.code && year == other.year
    end

    def to_s
      "<GB2260-#{@year||LATEST_YEAR} #{[province, prefecture, county].compact.map(&:name).join('/')}>"
    end

    def province
      Division.get(@code[0,2] + PROVINCE_SUFFIX, @year)
    end

    def is_province?
      province == self
    end

    def prefecture
      Division.get(@code[0,4] + PREFECTURE_SUFFIX, @year) unless is_province?
    end

    def is_prefecture?
      prefecture == self
    end

    def county
      self unless is_province? or is_prefecture?
    end

    def is_county?
      !is_province? and !is_prefecture?
    end
  end
end
