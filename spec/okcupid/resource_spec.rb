require 'spec_helper'

describe OkCupid::Resource do
  let(:doc) { double() }
  let(:css) { double(text: text) }
  let(:text) { 'foobar' }
  let(:resource) { OkCupid::Resource.new doc }

  before(:each) { allow(doc).to receive(:css).and_return(css) }

  describe '#method_missing' do
    it 'should return the text for the specified css selector' do
      expect(resource.foobar).to match text
    end
  end
end
