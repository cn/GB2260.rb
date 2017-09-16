class GB2260
  class Division
    using DeprecationWarner

    attr_reader :code, :name, :revision
    deprecate :year, :revision

    def self.get(code, revision=nil)
      name = Data.search(code, revision)
      name && new(code, name, revision)
    end

    def self.batch(codes, revision=nil)
      codes.map { |code| get(code, revision) }.compact
    end

    def initialize(code, name, revision=nil)
      @code = code.to_s
      @name = name.to_s
      @revision = (revision || DEFAULT_REVISION).to_s
    end

    def ==(other)
      eql? other
    end

    def eql?(other)
      code == other.code && revision == other.revision
    end

    def description(separator = '/')
      [province, prefecture, county].compact.map(&:name).join(separator)
    end

    def to_s
      "<GB2260-#{revision} #{code} #{description}>"
    end

    def hash
      [@code, @revision].hash
    end

    def province
      Division.get(@code[0,2] + PROVINCE_SUFFIX, @revision)
    end

    def is_province?
      province == self
    end

    def prefecture
      Division.get(@code[0,4] + PREFECTURE_SUFFIX, @revision) unless is_province?
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
