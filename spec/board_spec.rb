require_relative 'spec_helper'

RSpec.describe Board do
  let(:board) { Board.new }

  describe '#new' do
    it 'sets @num_of_turns to 0' do
      expect(board.num_of_turns).to eq(0)
    end
  end

  describe '#white_pegs' do
    context 'when there are no elements of the guess inside the code' do
      it 'returns zero' do
        code = %w(red red blue orange)
        guess = %w(purple green yellow green)
        expect(board.white_pegs(code, guess)).to eq(0)
      end
    end

    context 'when the same elements in code and guess are in different positions' do
      it 'return the number of elements in common' do
        code = %w(red red blue orange)
        guess = %w(purple orange yellow green)
        expect(board.white_pegs(code, guess)).to eq(1)
      end
      it 'return the number of elements in common' do
        code = %w(red red blue orange)
        guess = %w(blue green red red)
        expect(board.white_pegs(code, guess)).to eq(3)
      end
    end

    context 'when the same elements in code and guess are in the same positions' do
      it 'returns zero' do
        code = %w(red red blue orange)
        guess = %w(red red blue orange)
        expect(board.white_pegs(code, guess)).to eq(0)
      end
    end
  end

  describe '#game_won?' do
    context 'when code and guess are identical' do
      it 'returns true' do
        code = %w(red red blue orange)
        guess = %w(red red blue orange)
        expect(board.game_won?(code, guess)).to be true
      end
    end

    context 'when the code and the guess are not identical' do
      it 'returns true' do
        code = %w(red red blue orange)
        guess = %w(red green blue orange)
        expect(board.game_won?(code, guess)).to be false
      end
    end
  end
end
