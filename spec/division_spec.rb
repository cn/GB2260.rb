require 'spec_helper'

describe GB2260::Division do
  it '#province returns a province division' do
    beijing = GB2260::Division.new(110000, '北京市')
    expect(GB2260::Division.get(110000).province).to eq(beijing)
    expect(GB2260::Division.get(110100).province).to eq(beijing)
    expect(GB2260::Division.get(110101).province).to eq(beijing)
  end

  it '#is_province? returns a boolean' do
    expect(GB2260::Division.get(110000).is_province?).to be_truthy
    expect(GB2260::Division.get(110100).is_province?).to be_falsey
    expect(GB2260::Division.get(110101).is_province?).to be_falsey
  end

  it '#prefecture returns a prefecture division' do
    bj_city = GB2260::Division.new(110100, '市辖区')
    expect(GB2260::Division.get(110000).prefecture).to be_nil
    expect(GB2260::Division.get(110100).prefecture).to eq(bj_city)
    expect(GB2260::Division.get(110101).prefecture).to eq(bj_city)
  end

  it '#is_prefecture? returns a boolean' do
    expect(GB2260::Division.get(110000).is_prefecture?).to be_falsey
    expect(GB2260::Division.get(110100).is_prefecture?).to be_truthy
    expect(GB2260::Division.get(110101).is_prefecture?).to be_falsey
  end

  it '#county returns a county division' do
    dongcheng = GB2260::Division.new(110101, '东城区')
    expect(GB2260::Division.get(110000).county).to be_nil
    expect(GB2260::Division.get(110100).county).to be_nil
    expect(GB2260::Division.get(110101).county).to eq(dongcheng)
  end
end
