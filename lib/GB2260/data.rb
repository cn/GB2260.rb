class GB2260
  class Data
    class << self
      def data
        @data ||= {
          '2014' => {
            '110000' => '北京市',
            '110100' => '市辖区',
            '110101' => '东城区',
            '110102' => '西城区',
            '110105' => '朝阳区',
            '110106' => '丰台区',
            '110107' => '石景山区',
            '110108' => '海淀区',
            '110109' => '门头沟区',
            '110111' => '房山区',
          },
        }
      end

      def search(code, year=nil)
        year ||= LATEST_YEAR
        data[year.to_s][code.to_s]
      end
    end
  end
end
