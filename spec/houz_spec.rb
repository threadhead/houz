require 'spec_helper'

describe 'Houz Srvr' do
  subject { last_response }

  describe 'app.m1_checksum' do
    it 'returns the checksum' do
      expect(app.send(:m1_checksum, "0Da1100345600")).to eq("37")
      expect(app.send(:m1_checksum, "0Da0100345600")).to eq("38")
      expect(app.send(:m1_checksum, "0Da1100123400")).to eq("3F")
      expect(app.send(:m1_checksum, "0Da4800567800")).to eq("25")
      expect(app.send(:m1_checksum, "1EAS10000000400000003000000000")).to eq("0E")
      expect(app.send(:m1_checksum, "16AR123456113401001100")).to eq("85")
      expect(app.send(:m1_checksum, "16XK263611502060511000")).to eq("6F")
      expect(app.send(:m1_checksum, "20CA0110205006004010500000000000")).to eq("C1")
      expect(app.send(:m1_checksum, "0BDS0019900")).to eq("94")
      expect(app.send(:m1_checksum, "19KC011120100002000000000")).to eq("10")
    end
  end

  describe 'app.assemble_message' do
    it 'retuns the assembled message string' do
      expect(app.send(:assemble_message, "a1100345600")).to eq("0Da110034560037")
      expect(app.send(:assemble_message, "a1100123400")).to eq("0Da11001234003F")
      expect(app.send(:assemble_message, "AS10000000400000003000000000")).to eq("1EAS100000004000000030000000000E")
      expect(app.send(:assemble_message, "AR123456113401001100")).to eq("16AR12345611340100110085")
      expect(app.send(:assemble_message, "DS0019900")).to eq("0BDS001990094")
      expect(app.send(:assemble_message, "KC011120100002000000000")).to eq("19KC01112010000200000000010")
    end
  end

  describe 'GET /' do
    before { get '/'}
    its (:status) { should eq(200) }
    its (:body) { should include('Hot Water On') }
  end


  describe 'GET /hot_water_on' do
    before { get '/hot_water_on'}
    its (:status) { should eq(200) }
    # its (:body) { should include('Hot Water On') }
  end
end
