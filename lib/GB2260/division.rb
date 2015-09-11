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

    def province
      Division.get(@code[0,2] + '0000'.freeze, @year)
    end
  end
end
