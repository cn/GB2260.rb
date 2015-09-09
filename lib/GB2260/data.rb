class GB2260
  class Data
    class << self
      def data
        @data ||= { "2014" => { "110000" => '北京市' }}
      end

      def search(code, year=nil)
        year ||= LATEST_YEAR
        data[year][code]
      end
    end
  end
end
