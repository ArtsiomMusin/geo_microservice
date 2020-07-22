#require 'rails_helper'

RSpec.describe Application, roda: :app, type: :route do
  subject { described_class }

  before { stub_const('Geocoder::DATA_PATH', "#{fixture_path}/city.csv") }

  describe '/' do
    let(:lat) { 45.05 }
    let(:lon) { 90.05 }

    context 'existing city' do
      before { get '/', city: 'City 17' }
      it { expect(last_response).to be_successful }
      it { expect(response_body).to eq([lat, lon]) }
    end

    context 'missing city' do
      before { get '/' }
      it { expect(last_response.status).to eq(422) }
      it { expect(response_body).to eq({ 'error' => 'City geo not found' }) }
    end
  end
end
