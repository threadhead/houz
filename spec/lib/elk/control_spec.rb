require 'spec_helper'

describe Elk::Control do
  let(:control) { Elk::Control.new('192.168.0.6', 2101) }

  describe 'app.m1_checksum' do
    it 'returns the checksum' do
      expect(control.m1_checksum "0Da1100345600").to eq("37")
      expect(control.m1_checksum "0Da0100345600").to eq("38")
      expect(control.m1_checksum "0Da1100123400").to eq("3F")
      expect(control.m1_checksum "0Da4800567800").to eq("25")
      expect(control.m1_checksum "1EAS10000000400000003000000000").to eq("0E")
      expect(control.m1_checksum "16AR123456113401001100").to eq("85")
      expect(control.m1_checksum "16XK263611502060511000").to eq("6F")
      expect(control.m1_checksum "20CA0110205006004010500000000000").to eq("C1")
      expect(control.m1_checksum "0BDS0019900").to eq("94")
      expect(control.m1_checksum "19KC011120100002000000000").to eq("10")
    end
  end

  describe 'app.assemble_message' do
    it 'retuns the assembled message string' do
      expect(control.assemble_message "a1100345600").to eq("0Da110034560037")
      expect(control.assemble_message "a1100123400").to eq("0Da11001234003F")
      expect(control.assemble_message "AS10000000400000003000000000").to eq("1EAS100000004000000030000000000E")
      expect(control.assemble_message "AR123456113401001100").to eq("16AR12345611340100110085")
      expect(control.assemble_message "DS0019900").to eq("0BDS001990094")
      expect(control.assemble_message "KC011120100002000000000").to eq("19KC01112010000200000000010")
    end
  end

  describe 'app.to_hex_string' do
    it 'returns a 2 character hex string' do
      expect(control.to_hex_string 1).to eq("01")
      expect(control.to_hex_string 15).to eq("0F")
      expect(control.to_hex_string 16).to eq("10")
      expect(control.to_hex_string 17).to eq("11")
      expect(control.to_hex_string 32).to eq("20")
      expect(control.to_hex_string 255).to eq("FF")
      expect(control.to_hex_string 256).to eq("00")
    end
  end

  describe 'app.string_number_justify' do
    it 'returns a number as a 0 justified string' do
      expect(control.string_number_justify '1').to eq("01")
      expect(control.string_number_justify '11').to eq("11")
      expect(control.string_number_justify '100').to eq("100")
      expect(control.string_number_justify '1', 4).to eq("0001")
      expect(control.string_number_justify '1', 3).to eq("001")
      expect(control.string_number_justify '1', 10).to eq("0000000001")
    end
  end


end
