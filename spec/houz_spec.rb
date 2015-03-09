require 'spec_helper'

describe 'Houz Srvr' do
  subject { last_response }

  describe 'GET /' do
    context 'unauthorized' do
      it 'return an http unauthorized' do
        get '/'
        expect(last_response.status).to eq(401)
      end
    end

    context 'authorized' do
      before do
        authorize 'admin', 'admin'
        get '/'
      end
      specify { expect(last_response.status).to eq(200) }
      specify { expect(last_response.body).to include('Hot Water On') }
    end
  end


  describe 'GET /hot_water_on' do
    context 'unauthorized' do
      it 'return an http unauthorized' do
        get '/hot_water_on'
        expect(last_response.status).to eq(401)
      end
    end

    # context 'authorized' do
    #   before do
    #     authorize 'admin', 'admin'
    #     get '/hot_water_on'
    #   end
    #   its (:status) { should eq(200) }
    #   # its (:body) { should include('Hot Water On') }
    # end
  end
end
