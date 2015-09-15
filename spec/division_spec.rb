require 'spec_helper'

describe GB2260::Division do
  context 'when @year is not given' do
    it 'uses lastest year as default' do
      expect(GB2260::Division.new(110000, '北京市').instance_variable_get(:@year)).to eq(GB2260::LATEST_YEAR)
    end

    it '.get returns an instance' do
      expect(GB2260::Division.get(110000)).to eq GB2260::Division.new(110000, '北京市')
      expect(GB2260::Division.get(110100)).to eq GB2260::Division.new(110100, '市辖区')
      expect(GB2260::Division.get(110101)).to eq GB2260::Division.new(110101, '东城区')
    end

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

    it '#is_county? returns a boolean' do
      expect(GB2260::Division.get(110000).is_county?).to be_falsey
      expect(GB2260::Division.get(110100).is_county?).to be_falsey
      expect(GB2260::Division.get(110101).is_county?).to be_truthy
    end

    it '#to_s returns a description' do
      expect("#{GB2260::Division.get(110000)}").to eq '<GB2260-2014 110000 北京市>'
      expect("#{GB2260::Division.get(110100)}").to eq '<GB2260-2014 110100 北京市/市辖区>'
      expect("#{GB2260::Division.get(110101)}").to eq '<GB2260-2014 110101 北京市/市辖区/东城区>'
    end

    it 'is hashable' do
      hsh = { GB2260::Division.get(110101) => 1 }
      hsh[GB2260::Division.get(110101)] = 2
      expect(hsh.size).to eq 1
    end
  end

  context 'when an earlier @year is given' do
    it 'does not equal to latest division' do
      expect(GB2260::Division.get(110101)).to_not eq GB2260::Division.get(110101, 2004)
    end
  end
end
