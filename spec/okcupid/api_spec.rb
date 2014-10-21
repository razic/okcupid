require 'spec_helper'

describe OkCupid::API do
  let(:api) { OkCupid::API.new }

  describe '#logged_in?' do
    subject { api.logged_in? }

    context 'when an authorization token is available' do
      before(:each) { api.authorization_token = true }

      it { is_expected.to be true }
    end

    context 'when an authorization token is not available' do
      it { is_expected.to be false }
    end
  end
end
