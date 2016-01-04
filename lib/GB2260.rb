require "GB2260/version"
require "GB2260/constants"
require "GB2260/deprecation"
require "GB2260/data"
require "GB2260/division"

class GB2260
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
    @all_code ||= Data.data[@revision].keys.freeze
  end

  def provinces
    Division.batch all_code.select { |c| c.end_with? PROVINCE_SUFFIX }, @revision
  end

  def prefectures(province_code)
    province_prefix = province_code.to_s[0,2].freeze
    Division.batch(all_code.lazy
      .select { |c| c.start_with? province_prefix }
      .select { |c| c.end_with? PREFECTURE_SUFFIX }
      .reject { |c| c.end_with? PROVINCE_SUFFIX }
      .force, @revision)
  end

  def counties(prefecture_code)
    prefecture_prefix = prefecture_code.to_s[0,4].freeze
    Division.batch(all_code.lazy
      .select { |c| c.start_with? prefecture_prefix }
      .reject { |c| c.end_with? PREFECTURE_SUFFIX }
      .force, @revision)
  end
end
