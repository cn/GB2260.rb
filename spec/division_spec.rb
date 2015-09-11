require 'spec_helper'

describe GB2260::Division do
  it '#province returns a province division' do
    beijing = GB2260::Division.new(110000, '北京市')
    expect(GB2260::Division.get(110000).province).to eq(beijing)
    expect(GB2260::Division.get(110100).province).to eq(beijing)
    expect(GB2260::Division.get(110101).province).to eq(beijing)
  end
end
