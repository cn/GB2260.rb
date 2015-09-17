require 'spec_helper'

describe GB2260::Data do
  describe '.data' do
    subject { GB2260::Data.data }
    it { is_expected.to be_instance_of(Hash) }
  end
end
