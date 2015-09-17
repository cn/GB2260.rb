class GB2260
  class Data
    GEM_DIR = File.join(File.dirname(__FILE__), '../../').freeze

    class << self
      def data
        Dir.chdir(GEM_DIR) do
          @data ||= fetch_data(GEM_DIR)
        end
      end

      def search(code, year=nil)
        year ||= LATEST_YEAR
        data[year.to_s][code.to_s]
      end

      private

      def fetch_data(dir)
        Hash[array_data(dir)]
      end

      def array_data(dir)
        Dir["data/*.txt"].map do |fn|
          [strip_year(fn), Hash[per_year_data(real_path(dir, fn))]]
        end
      end

      def per_year_data(filepath)
        File.readlines(filepath).map {|l| l.chomp.split("\t") }
      end

      def real_path(dir, filename)
        File.expand_path(File.join(dir, filename))
      end

      def strip_year(filename)
        filename.sub(/data\/GB2260-/, '').sub(/\.txt$/, '')
      end
    end
  end
end
