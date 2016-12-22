require_relative 'spec_helper'

RSpec.describe Code do
  let(:code) { Code.new }

  describe '#create_code' do
    it 'creates a code of four elements' do
      expect(code.create_code.length).to eq(4)
    end

    it 'only contains elements of @code_elements' do
      code.create_code.each do |element|
        expect(code.code_elements).to include(element)
      end
    end
  end

  describe '#code_elements' do
    it 'is an array of elements from which to make a code' do
      expect(code.code).to be_kind_of(Array)
    end
  end
end
