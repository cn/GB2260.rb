require 'spec_helper'

describe GB2260 do
  it 'has a version number' do
    expect(GB2260::VERSION).not_to be nil
  end

  describe ".revisions" do
    it 'returns all revisions' do
      expect(GB2260.revisions).to be_instance_of(Array)
    end
  end

  describe '#get' do
    subject { GB2260.new.get(110000) }
    it 'returns a division' do
      is_expected.to be_instance_of GB2260::Division
      is_expected.to eq GB2260::Division.new(110000, '北京市')
    end
  end

  describe "#provinces" do
    subject { GB2260.new.provinces }
    it 'returns only provinces' do
      is_expected.to include(GB2260::Division.get(110000))
      is_expected.to_not include(GB2260::Division.get(110101))
      expect(subject.all?(&:is_province?)).to be_truthy
    end
  end

  describe '#prefectures' do
    subject { GB2260.new.prefectures(110000) }
    it 'return only prefectures' do
      is_expected.to include(GB2260::Division.get(110100))
      is_expected.to_not include(GB2260::Division.get(110000))
      is_expected.to_not include(GB2260::Division.get(110101))
      expect(subject.all?(&:is_prefecture?)).to be_truthy
    end
  end

  describe '#counties' do
    subject { GB2260.new.counties(110100) }
    it 'return only counties' do
      is_expected.to include(GB2260::Division.get(110101))
      is_expected.to_not include(GB2260::Division.get(110000))
      is_expected.to_not include(GB2260::Division.get(110100))
      expect(subject.all?(&:is_county?)).to be_truthy
    end
  end
end
