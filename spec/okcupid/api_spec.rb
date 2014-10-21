require 'spec_helper'

describe OkCupid::API do
  let(:api) { OkCupid::API.new }

  describe '#login' do
    subject { api.login(username, password) }

    context 'when successful' do
      let(:username) { 'cute_taco' }
      let(:password) { 'boyzRUL3!' }

      it 'returns the cookie' do
        VCR.use_cassette 'successful_login' do
          expect(subject).to match OkCupid::API::COOKIE_REGEX
        end
      end
    end

    context 'when unsuccessful' do
      let(:username) { 'cat_in_a_box' }
      let(:password) { 'idontknow' }

      it 'returns nothing' do
        VCR.use_cassette 'unsuccessful_login' do
          expect(subject).to be nil
        end
      end
    end
  end

  describe '#logged_in?' do
    subject { api.logged_in? }

    context 'when the cookie is set' do
      before(:each) { api.instance_variable_set(:@cookie, true) }

      it { is_expected.to be true }
    end

    context 'when the cookies is not set' do
      it { is_expected.to be false }
    end
  end
end
