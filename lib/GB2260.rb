require "GB2260/version"
require "GB2260/constants"
require "GB2260/deprecation"
require "GB2260/data"
require "GB2260/division"
require "GB2260/array"

class GB2260
  using ArrayExtensions

  def self.revisions
    Data.data.keys.reverse
  end

  def initialize(revision=nil)
    @revision = (revision || LATEST_REVISION).to_s
  end

  def get(code)
    Division.get(code, @revision)
  end

  def all_code
    Data.data[@revision].keys
  end

  def provinces
    Division.batch all_code.select_end_with(PROVINCE_SUFFIX), @revision
  end

  def prefectures(province_code)
    Division.batch(all_code
      .select_start_with(province_code.to_s[0,2])
      .select_end_with(PREFECTURE_SUFFIX)
      .reject_end_with(PROVINCE_SUFFIX),
    @revision)
  end

  def regex_prefectures(province_code)
    Division.batch(all_code
      .select { |c| c =~ /^#{province_code.to_s[0,2]}(?!#{PROVINCE_SUFFIX})/ },
    @revision)
  end

  def counties(prefecture_code)
    Division.batch(all_code
      .select_start_with(prefecture_code.to_s[0,4])
      .reject_end_with(PREFECTURE_SUFFIX),
    @revision)
  end

  def regex_counties(prefecture_code)
    Division.batch(all_code
      .select { |c| c =~ /^#{prefecture_code.to_s[0,4]}(?!#{PREFECTURE_SUFFIX})/ },
    @revision)
  end
end
