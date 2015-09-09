require 'spec_helper'

describe GB2260 do
  it 'has a version number' do
    expect(GB2260::VERSION).not_to be nil
  end

  it '#get returns a division' do
    expect(GB2260.new.get(110000)).to eq(GB2260::Division.new(110000, '北京市'))
  end
end
