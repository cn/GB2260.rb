require 'pathname'
require 'csv'

class GB2260
  class Data
    GEM_DIR = File.join(File.dirname(__FILE__), '../../').freeze

    class << self
      def data
        Dir.chdir(GEM_DIR) do
          @data ||= fetch_data(GEM_DIR)
        end
      end

      def search(code, revision=nil)
        revision ||= DEFAULT_REVISION
        data[revision.to_s][code.to_s]
      end

      private

      def fetch_data(dir)
        Hash[array_data(dir)]
      end

      def array_data(dir)
        data_files.map do |fn|
          [revision_from(fn).to_s, Hash[per_revision_data(real_path(dir, fn))]]
        end
      end

      def data_files
        Dir['data/**/*.tsv'].reject { |fn| fn =~ /sources/ }
      end

      def per_revision_data(filepath)
        CSV.readlines(filepath, col_sep: "\t", headers: true, header_converters: :symbol)
           .map { |div| [div[:code], div[:name]] }
      end

      def real_path(dir, filename)
        File.expand_path(File.join(dir, filename))
      end

      def revision_from(filename)
        (Pathname(File.dirname(filename)).each_filename.to_a[1..-1] +
         [File.basename(filename, '.tsv')])
          .join(NAMESPACE_SEPARATOR)
      end
    end
  end
end
