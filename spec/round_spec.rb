
require './lib/turn'
require './lib/card'
require './lib/deck'
require './lib/round'

RSpec.describe Round do
  # Uses before method to repeat code below for each it method
  before(:each) do
    @card_1 = Card.new('What is the capital of Alaska?', 'Juneau', :Geography)
    @card_2 = Card.new(
      'The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?', 'Mars', :STEM
    )
    @card_3 = Card.new('Describe in words the exact direction that is 697.5° clockwise from due north?',
                       'North north west', :STEM)
    @deck = Deck.new([@card_1, @card_2, @card_3])
    @round = Round.new(@deck)
  end
  it 'exists' do
    expect(@round).to be_instance_of(Round)
  end
  it 'has deck' do
    expect(@round.deck).to eq(@deck)
  end
  it 'turns to be empty array' do
    expect(@round.turns).to eq([])
  end
  it 'current card is correct' do
    expect(@round.current_card).to eq(@card_1)
  end
  it 'new turn is correct' do
    @new_turn = @round.take_turn('Juneau')

    expect(@new_turn).to eq(@round.turn)
  end
  it 'turn class is equal to turn' do
    @new_turn = @round.take_turn('Juneau')

    expect(@new_turn.class).to eq(Turn)
  end
  it 'turn displays true with correct?' do
    @new_turn = @round.take_turn('Juneau')

    expect(@new_turn.correct?).to eq(true)
  end
  it 'turns is equal to current card' do
    @new_turn = @round.take_turn('Juneau')

    expect(@round.turns).to eq([@round.turn])
  end
  it 'number correct, correctly displayed as 1' do
    @new_turn = @round.take_turn('Juneau')

    expect(@round.number_correct).to eq(1)
  end
  it 'current card next in line' do
    @new_turn = @round.take_turn('Juneau')

    expect(@round.current_card).to eq(@card_2)
  end
  it 'check to see if next turn works' do
    @new_turn = @round.take_turn('Juneau')
    @new_turn = @round.take_turn('Venus')

    expect(@round.turns.count).to eq(2)
    expect(@round.turns.last.feedback).to eq('Incorrect.')
    expect(@round.number_correct).to eq(1)
  end
  it 'percent and category checks' do
    @new_turn = @round.take_turn('Juneau')
    @new_turn = @round.take_turn('Venus')

    expect(@round.number_correct_by_category(:Geography).to eq(1))
    expect(@round.number_correct_by_category(:STEM).to eq(0))
    expect(@round.percent_correct).to eq(50.0)
    expect(@round.percent_correct_by_category(:Geography)).to eq(100.0)
  end
  it 'checks to see if last card is in correct position' do
    @new_turn = @round.take_turn('Juneau')
    @new_turn = @round.take_turn('Venus')

    expect(@round.current_card).to eq(@card_3)
  end
end
