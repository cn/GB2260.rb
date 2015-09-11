class GB2260
  class Data
    class << self
      def data
        gem_dir = File.join(File.dirname(__FILE__), '../../')
        Dir.chdir(gem_dir) do
          @data ||= Hash[Dir.glob("data/*.txt").map do |fn|
            [
              fn.gsub(/data\/GB2260-/, '').gsub(/\.txt$/, ''),
              Hash[
                File.readlines(File.expand_path(File.join(gem_dir, fn))).map do |l|
                  l.strip.split("\t")
                end]
            ]
          end]
        end
      end

      def search(code, year=nil)
        year ||= LATEST_YEAR
        data[year.to_s][code.to_s]
      end
    end
  end
end
