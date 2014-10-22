require 'spec_helper'

describe OkCupid::API do
  let(:api) { OkCupid::API.new }

  describe '#login' do
    before :each do
      VCR.use_cassette cassette do
        api.send :login, username, password
      end
    end

    let(:cookie) { api.instance_variable_get(:@cookie) }

    context 'when successful' do
      let(:username) { 'cute_taco' }
      let(:password) { 'boyzRUL3!' }
      let(:cassette) { 'successful_login' }

      describe "@cookie" do
        subject { cookie }

        it { is_expected.to match OkCupid::API::COOKIE_REGEX }
      end
    end

    context 'when unsuccessful' do
      let(:username) { 'cat_in_a_box' }
      let(:password) { 'idontknow' }
      let(:cassette) { 'unsuccessful_login' }

      describe "@cookie" do
        subject { cookie }

        it { is_expected.to be nil }
      end
    end
  end

  describe '#logged_in?' do
    subject { api.logged_in? }

    before(:each) { api.instance_variable_set(:@cookie, cookie) }

    context 'when @cookie is truthy' do
      let(:cookie) { "session=1234567890;" }

      it { is_expected.to be true }
    end

    context 'when @cookie is falsey' do
      let(:cookie) { nil }

      it { is_expected.to be false }
    end
  end

  describe '#messages' do
    context 'logged in' do
      subject do
        VCR.use_cassette cassette do
          api.send :login, username, password
          api.messages
        end
      end

      let(:messages) { subject }
      let(:username) { 'cute_taco' }
      let(:password) { 'boyzRUL3!' }

      describe 'when there are messages' do
        let(:cassette) { 'messages' }

        it { expect(messages).to be_an Array }
        it { expect(messages).to_not be_empty }

        it 'should initialize an OkCupid::Message for each message' do
          messages.each do |message|
            expect(message).to be_an OkCupid::Message
          end
        end
      end
    end
  end
end
