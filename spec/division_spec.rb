require 'spec_helper'

describe GB2260::Division do
  describe '.get' do
    let(:division) { GB2260::Division.get(110000) }
    let(:not_exists_division) { GB2260::Division.get(000000) }

    it 'returns the division' do
      expect(division).to eq GB2260::Division.new(110000, '北京市')
    end

    it 'returns nil when the division doesnt exist' do
      expect(not_exists_division).to be_nil
    end
  end

  context 'when @revision is not given' do
    subject(:beijing) { GB2260::Division.get(110000) }
    subject(:bj_city) { GB2260::Division.get(110100) }
    subject(:dc_dist) { GB2260::Division.get(110101) }

    describe '.get' do
      it 'returns an instance' do
        expect(beijing).to eq GB2260::Division.new(110000, '北京市')
        expect(bj_city).to eq GB2260::Division.new(110100, '市辖区')
        expect(dc_dist).to eq GB2260::Division.new(110101, '东城区')
      end
    end

    describe '.batch' do
      subject { GB2260::Division.batch([110000, 110100, 110101]) }
      it 'returns array of divisions' do
        is_expected.to eq [beijing, bj_city, dc_dist]
      end
    end

    describe '#province' do
      it 'returns a province division' do
        expect(beijing.province).to eq beijing
        expect(bj_city.province).to eq beijing
        expect(dc_dist.province).to eq beijing
      end
    end

    describe '#is_province?' do
      it 'returns a boolean' do
        expect(beijing.is_province?).to be_truthy
        expect(bj_city.is_province?).to be_falsey
        expect(dc_dist.is_province?).to be_falsey
      end
    end

    describe '#prefecture' do
      it 'returns a prefecture division' do
        expect(beijing.prefecture).to be_nil
        expect(bj_city.prefecture).to eq bj_city
        expect(dc_dist.prefecture).to eq bj_city
      end
    end

    describe '#is_prefecture?' do
      it 'returns a boolean' do
        expect(beijing.is_prefecture?).to be_falsey
        expect(bj_city.is_prefecture?).to be_truthy
        expect(dc_dist.is_prefecture?).to be_falsey
      end
    end

    describe '#county' do
      it 'returns a county division' do
        expect(beijing.county).to be_nil
        expect(bj_city.county).to be_nil
        expect(dc_dist.county).to eq dc_dist
      end
    end

    describe '#is_county?' do
      it 'returns a boolean' do
        expect(beijing.is_county?).to be_falsey
        expect(bj_city.is_county?).to be_falsey
        expect(dc_dist.is_county?).to be_truthy
      end
    end

    describe '#to_s' do
      it 'returns a description' do
        expect("#{beijing}").to eq '<GB2260-2014 110000 北京市>'
        expect("#{bj_city}").to eq '<GB2260-2014 110100 北京市/市辖区>'
        expect("#{dc_dist}").to eq '<GB2260-2014 110101 北京市/市辖区/东城区>'
      end
    end

    it 'is hashable' do
      hsh = { dc_dist => 1 }
      hsh[dc_dist] = 2
      expect(hsh.size).to eq 1
    end

    it 'uses lastest revision as default' do
      expect(GB2260::Division.new(110000, '北京市').revision).to eq(GB2260::LATEST_REVISION)
    end
  end

  context 'when an earlier @revision is given' do
    it 'does not equal to latest division' do
      expect(GB2260::Division.get(110101)).to_not eq GB2260::Division.get(110101, 2004)
    end
  end

  context 'when use `year`' do
    it 'shows deprecation warning' do
      expect { GB2260::Division.new(110000, '北京市').year }.to output(/DEPRECATION/).to_stderr
    end
  end
end
