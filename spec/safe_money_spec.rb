require 'spec_helper'

describe SafeMoney do

  it 'SafeMoney.new(1000) should rais a NoMethodError' do
    expect{ SafeMoney.new(1000) }.to raise_error NoMethodError
  end

  it 'SafeMoney.cents(1000) should be frozen' do
    expect( SafeMoney.cents(1000) ).to be_frozen
  end

  # SafeMoney.cents

  it 'SafeMoney.cents(1000).inspect should equal "$10.00"' do
    expect( SafeMoney.cents(1000).inspect ).to eq "$10.00"
  end

  it 'SafeMoney.cents(10.00).inspect should equal "$0.10"' do
    expect( SafeMoney.cents(10.00).inspect ).to eq "$0.10"
  end

  it 'SafeMoney.cents(10.15) should raise a SafeMoney::CoercionError' do
    expect{ SafeMoney.cents(10.15) }.to raise_error SafeMoney::CoercionError, '10.15 cannot safely be converted into cents'
  end

  # SafeMoney.dollars

  it 'SafeMoney.dollars(1000).inspect should equal "$1000.00"' do
    expect( SafeMoney.dollars(1000).inspect ).to eq "$1000.00"
  end

  it 'SafeMoney.dollars(10.15).inspect should equal "$10.15"' do
    expect( SafeMoney.dollars(10.15).inspect ).to eq "$10.15"
  end

  it 'SafeMoney.dollars(10.154) should raise a SafeMoney::CoercionError' do
    expect{ SafeMoney.dollars(10.154) }.to raise_error SafeMoney::CoercionError, '10.154 cannot safely be converted into cents'
  end


  it 'SafeMoney.cents(1020) should equal 1020' do
    expect( SafeMoney.cents(1020) ).to eq 1020
  end

  it 'SafeMoney.cents(1020).to_dollars should equal 10.20' do
    expect( SafeMoney.cents(1020).to_dollars ).to eq 10.20
  end

  it 'SafeMoney.cents(1020).positive? should be true' do
    expect( SafeMoney.cents(1020).positive? ).to be_truthy
  end

  it 'SafeMoney.cents(1020).negative? should be false' do
    expect( SafeMoney.cents(1020).negative? ).to be_falsey
  end

  it 'SafeMoney.cents(1020).inspect should equal "$10.20"' do
    expect( SafeMoney.cents(1020).inspect ).to eq "$10.20"
  end


  it 'SafeMoney.cents(-1020) should equal -1020' do
    expect( SafeMoney.cents(-1020) ).to eq(-1020)
  end

  it 'SafeMoney.cents(-1020).to_dollars should equal -10.20' do
    expect( SafeMoney.cents(-1020).to_dollars ).to eq(-10.20)
  end

  it 'SafeMoney.cents(-1020).positive? should be false' do
    expect( SafeMoney.cents(-1020).positive? ).to be_falsey
  end

  it 'SafeMoney.cents(-1020).negative? should be true' do
    expect( SafeMoney.cents(-1020).negative? ).to be_truthy
  end

  it 'SafeMoney.cents(-1020).inspect should equal "-$10.20"' do
    expect( SafeMoney.cents(-1020).inspect ).to eq "-$10.20"
  end



  it 'SafeMoney.dollars(10.20) should equal 1020' do
    expect( SafeMoney.dollars(10.20) ).to eq 1020
  end

  it 'SafeMoney.dollars(10.20).to_dollars should equal 10.20' do
    expect( SafeMoney.dollars(10.20).to_dollars ).to eq 10.20
  end

  it 'SafeMoney.dollars(10.20).positive? should be true' do
    expect( SafeMoney.dollars(10.20).positive? ).to be_truthy
  end

  it 'SafeMoney.dollars(10.20).negative? should be false' do
    expect( SafeMoney.dollars(10.20).negative? ).to be_falsey
  end

  it 'SafeMoney.dollars(10.20).inspect should equal "$10.20"' do
    expect( SafeMoney.dollars(10.20).inspect ).to eq "$10.20"
  end


  it 'SafeMoney.dollars(-10.20) should equal -1020' do
    expect( SafeMoney.dollars(-10.20) ).to eq(-1020)
  end

  it 'SafeMoney.dollars(-10.20).to_dollars should equal -10.20' do
    expect( SafeMoney.dollars(-10.20).to_dollars ).to eq(-10.20)
  end

  it 'SafeMoney.dollars(-10.20).positive? should be false' do
    expect( SafeMoney.dollars(-10.20).positive? ).to be_falsey
  end

  it 'SafeMoney.dollars(-10.20).negative? should be true' do
    expect( SafeMoney.dollars(-10.20).negative? ).to be_truthy
  end

  it 'SafeMoney.dollars(-10.20).inspect should equal "-$10.20"' do
    expect( SafeMoney.dollars(-10.20).inspect ).to eq "-$10.20"
  end




  it 'SafeMoney.cents(199) == SafeMoney.cents(199) should be true' do
    expect( SafeMoney.cents(199) == SafeMoney.cents(199) ).to be_truthy
  end

  it 'SafeMoney.cents(199) == SafeMoney.cents(200) should be false' do
    expect( SafeMoney.cents(199) == SafeMoney.cents(200) ).to be_falsey
  end

  it 'SafeMoney.cents(199) > SafeMoney.cents(199) should be false' do
    expect( SafeMoney.cents(199) > SafeMoney.cents(199) ).to be_falsey
  end

  it 'SafeMoney.cents(199) < SafeMoney.cents(199) should be false' do
    expect( SafeMoney.cents(199) < SafeMoney.cents(199) ).to be_falsey
  end

  it 'SafeMoney.cents(199) > SafeMoney.cents(299) should be false' do
    expect( SafeMoney.cents(199) > SafeMoney.cents(199) ).to be_falsey
  end

  it 'SafeMoney.cents(199) < SafeMoney.cents(299) should be true' do
    expect( SafeMoney.cents(199) < SafeMoney.cents(299) ).to be_truthy
  end

  it 'SafeMoney.cents(200) > 100 should be true' do
    expect( SafeMoney.cents(200) > 100 ).to be_truthy
  end

  it '200 > SafeMoney.cents(100) should be true' do
    expect( 200 > SafeMoney.cents(100) ).to be_truthy
  end

  it 'SafeMoney.cents(200) < 100 should be false' do
    expect( SafeMoney.cents(200) < 100 ).to be_falsey
  end

  it '200 < SafeMoney.cents(100) should be false' do
    expect( 200 < SafeMoney.cents(100) ).to be_falsey
  end


  it 'SafeMoney.cents(1245) should equal SafeMoney.cents(1245)' do
    expect( SafeMoney.cents(1245) ).to eq SafeMoney.cents(1245)
  end

  it 'SafeMoney.cents(15) + 5 should equal SafeMoney.cents(20)' do
    expect(SafeMoney.cents(15) + 5).to eq SafeMoney.cents(20)
  end


  it 'SafeMoney.cents(1024) should not raise error' do
    expect{ SafeMoney.cents(1024) }.to_not raise_error
  end

  it 'SafeMoney.cents(10.24) should raise SafeMoney::CoercionError' do
    expect{ SafeMoney.cents(10.24) }.to raise_error SafeMoney::CoercionError, '10.24 cannot safely be converted into cents'
  end

  it 'SafeMoney.cents(nil) should raise ArgumentError' do
    expect{ SafeMoney.cents(nil) }.to raise_error ArgumentError, 'cents must be Numeric'
  end

  it 'SafeMoney.dollars(nil) should raise ArgumentError' do
    expect{ SafeMoney.cents(nil) }.to raise_error ArgumentError, 'cents must be Numeric'
  end

  it 'SafeMoney.cents("12") should raise ArgumentError' do
    expect{ SafeMoney.cents("12") }.to raise_error ArgumentError, 'cents must be Numeric'
  end

  it 'SafeMoney.dollars("12") should raise ArgumentError' do
    expect{ SafeMoney.cents("12") }.to raise_error ArgumentError, 'cents must be Numeric'
  end



  it 'SafeMoney.cents(100) / 2 equal SafeMoney.cents(50)' do
    expect( SafeMoney.cents(100) / 2 ).to eq SafeMoney.cents(50)
  end

  it 'SafeMoney.cents(100) / 2.0 equal SafeMoney.cents(50)' do
    expect( SafeMoney.cents(100) / 2.0 ).to eq SafeMoney.cents(50)
  end

  it 'SafeMoney.cents(100) / 0.2 equal SafeMoney.cents(500)' do
    expect( SafeMoney.cents(100) / 0.2 ).to eq SafeMoney.cents(500)
  end

  it 'SafeMoney.cents(100) / 0.3 should raise SafeMoney::ArithmeticError' do
    expect{ SafeMoney.cents(100) / 0.3 }.to raise_error SafeMoney::ArithmeticError, "$1.00 cannot be safely divided by 0.3"
  end

  it 'SafeMoney.cents(1099) / 0.3 should raise SafeMoney::ArithmeticError' do
    expect{ SafeMoney.cents(1099) / 2 }.to raise_error SafeMoney::ArithmeticError, "$10.99 cannot be safely divided by 2"
  end

  it 'SafeMoney.cents(100) * 1 should equal SafeMoney.cents(100)' do
    expect( SafeMoney.cents(100) * 1 ).to eq SafeMoney.cents(100)
  end

  it 'SafeMoney.cents(100) * 0.5 should equal SafeMoney.cents(50)' do
    expect( SafeMoney.cents(100) * 0.5 ).to eq SafeMoney.cents(50)
  end

  it 'SafeMoney.cents(100) * 0.5467 should raise SafeMoney::ArithmeticError' do
    expect{ SafeMoney.cents(100) * 0.5467 }.to raise_error SafeMoney::ArithmeticError, "$1.00 cannot be safely multiplied by 0.5467"
  end


  it '12.35.dollars should equal SafeMoney.dollars(12.35)' do
    expect( 12.35.dollars ).to eq SafeMoney.dollars(12.35)
  end

  it '12.35.cents should raise a SafeMoney::CoercionError' do
    expect{ 12.35.cents }.to raise_error SafeMoney::CoercionError
  end

  it '12.cents should equal SafeMoney.cents(12)' do
    expect( 12.cents ).to eq SafeMoney.cents(12)
  end

  it 'SafeMoney.cents(SafeMoney.cents(1234)) should equal SafeMoney.cents(1234)' do
    money = SafeMoney.cents(1234)
    expect( SafeMoney.cents(money) ).to be money
  end

  it 'SafeMoney.dollars(SafeMoney.dollars(1234)) should equal SafeMoney.dollars(1234)' do
    money = SafeMoney.dollars(1234)
    expect( SafeMoney.dollars(money) ).to be money
  end

  it 'SafeMoney.cents(1234).as_json should equal 1234' do
    expect( SafeMoney.cents(1234).as_json ).to eq 1234
  end

  it 'SafeMoney.cents(1234).to_json should equal "1234"' do
    expect( SafeMoney.cents(1234).to_json ).to eq "1234"
  end


  it '-SafeMoney.cents(1234) should equal SafeMoney.cents(-1234)' do
    expect( -SafeMoney.cents(1234) ).to eq SafeMoney.cents(-1234)
  end

  # Coercion

  it 'SafeMoney.cents(1099).coerce(10) should equal [10, 1099]' do
    left, right = SafeMoney.cents(1099).coerce(10)
    expect( left  ).to be_a Integer
    expect( right ).to be_a Integer
    expect( left  ).to eq 10
    expect( right ).to eq 1099
  end

  it 'SafeMoney.cents(1099).coerce(10.5) should equal [10, 1099.0]' do
    left, right = SafeMoney.cents(1099).coerce(10.5)
    expect( left  ).to be_a Float
    expect( right ).to be_a Float
    expect( left  ).to eq 10.5
    expect( right ).to eq 1099.0
  end

  # Equality

  it 'treats identical amounts as equal numbers' do
    a = 10.dollars
    b = 10.dollars
    expect( a ).to eq b
    expect( a ).to equal b
    expect( a ).to eq 1000
    expect( a ).to equal 1000
    expect( a.eql?(1000) ).to be true
    expect( a.equal?(1000) ).to be true
    expect( a.eql?(b) ).to be true
    expect( a.equal?(b) ).to be true
    expect( [a,b].uniq ).to eq [a]
  end

end
