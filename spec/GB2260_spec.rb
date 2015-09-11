require 'spec_helper'

describe GB2260 do
  it 'has a version number' do
    expect(GB2260::VERSION).not_to be nil
  end

  it '#get returns a division' do
    expect(GB2260.new.get(110000)).to eq(GB2260::Division.new(110000, '北京市'))
  end

  it '#provinces' do
    expect(GB2260.new.provinces).to include(GB2260::Division.get(110000))
    expect(GB2260.new.provinces).to_not include(GB2260::Division.get(110101))
    expect(GB2260.new.provinces.all?(&:is_province?)).to be_truthy
  end

  it '#prefectures' do
    expect(GB2260.new.prefectures(110000)).to include(GB2260::Division.get(110100))
    expect(GB2260.new.prefectures(110000)).to_not include(GB2260::Division.get(110000))
    expect(GB2260.new.prefectures(110000)).to_not include(GB2260::Division.get(110101))
    expect(GB2260.new.prefectures(110000).all?(&:is_prefecture?)).to be_truthy
  end
end
