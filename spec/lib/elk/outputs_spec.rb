require 'spec_helper'

describe Elk::Outputs do
  before { @outs = Elk::Outputs.new }

  it { expect(@outs.outputs.size).to eq(212) }
  it { expect(@outs.outputs[0]).to be_a(Elk::Output) }

  it 'in the outputs array, the first index should be number 1, not 0' do
    expect(@outs.outputs.first.number).to eq(1)
  end

  it 'in the outputs array, the last index should be number 212, not 211' do
    expect(@outs.outputs.last.number).to eq(212)
  end

  it 'first output is number 1' do
    expect(@outs.number(1)).to eq(1)
  end

  it 'last output is number 212' do
    expect(@outs.number(212)).to eq(212)
  end

  it 'set the value of an output and return' do
    @outs.set_state(4, '1')
    expect(@outs.value(4)).to be_true
    @outs.set_state(4, '0')
    expect(@outs.value(4)).to be_false
  end

  it 'sets output values on a passed elk outputs message string' do
    @outs.set_state_elk_string('100000000')
    expect(@outs.value(1)).to be_true
    expect(@outs.value(2)).to be_false

    @outs.set_state_elk_string('010000000')
    expect(@outs.value(1)).to be_false
    expect(@outs.value(2)).to be_true

    @outs.set_state_elk_string('000000001')
    expect(@outs.value(9)).to be_true
  end

end
