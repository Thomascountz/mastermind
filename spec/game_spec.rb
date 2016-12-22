require_relative 'spec_helper'

RSpec.describe Game do
  let(:game) { Game.new }
  
  describe '#new' do
    it 'sets @board to an instance of Board' do
      board = game.instance_variable_get(:@board)
      expect(board).to be_kind_of(Board)
    end
    it 'sets @code to an instance of Code' do
      code = game.instance_variable_get(:@code)
      expect(code).to be_kind_of(Code)
    end
  end
  
  describe '#input_valid?' do
    context 'when the input length is four and contains only code elements' do
      it 'returns true' do
        input = %w(red green yellow blue)
        expect(game.input_valid?(input)).to be true
      end
    end
    context 'when the input length is four and does not contain only code elements' do
      it 'returns false' do
        input = %w(red aqua maroon pink)
        expect(game.input_valid?(input)).to be false
      end
    end
    context 'when the input length is not four and contains only code elements' do
      it 'returns false' do
        input = %w(red green)
        expect(game.input_valid?(input)).to be false
      end
    end  
    context 'when the input length is not four and does not contain only  code elements' do
      it 'returns false' do
        input = %w(fuscia sand cotton)
        expect(game.input_valid?(input)).to be false
      end
    end    
  end
end