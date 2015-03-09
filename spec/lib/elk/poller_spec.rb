require 'spec_helper'

describe Elk::Poller do
  before do
    @elk_comm = double()
    @poller = Elk::Poller.new(@elk_comm)
  end

  # after { @poller.terminate }

  it { expect(@poller.running).to eq(false) }

  describe '.send_message_for' do
    before do
      @message = 'abc123'
    end

    it 'just a little test' do
      # @elk_comm.stub(:send_message)
      # expect(@elk_comm).to receive(:send_message).with(@message)
      # @poller.send_message_for(@message, 1)
    end
  end
end
