require 'spec_helper'

describe Elk::Output do
  before { @out = Elk::Output.new(3, '0') }

  it { expect(@out.value).to eq(false) }
  it { expect(@out.number).to eq(3) }

  it 'value returns true when on' do
    @out.value = '1'
    expect(@out.value).to eq(true)
  end

  it 'value return false when off' do
    @out.value = '0'
    expect(@out.value).to eq(false)
  end

  it 'value return false when set to junk string' do
    @out.value = 'asdf'
    expect(@out.value).to eq(false)
  end
end
