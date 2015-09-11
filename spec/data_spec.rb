require 'spec_helper'

describe GB2260::Data do
  it '.data' do
    expect(GB2260::Data.data).to be_instance_of(Hash)
  end
end
