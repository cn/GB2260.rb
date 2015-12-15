require 'spec_helper'
require 'benchmark'

n = 100

g = GB2260.new
province_code = g.provinces.sample.code
prefecture_code = g.prefectures(province_code).sample.code

Benchmark.bmbm do |x|
  x.report("prefectures.with?") { n.times do g.prefectures(province_code) end }
  x.report("prefectures.regex")  { n.times do g.regex_prefectures(province_code) end }
end

Benchmark.bmbm do |x|
  x.report("couties.with?") { n.times do g.counties(prefecture_code) end }
  x.report("couties.regex")  { n.times do g.regex_counties(prefecture_code) end }
end
