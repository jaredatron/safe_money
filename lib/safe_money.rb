require "safe_money/version"

class SafeMoney

  CoercionError   = Class.new(TypeError)
  ArithmeticError = Class.new(ArgumentError)

  class << self

    def cents number
      return number if number.is_a?(self)
      raise ArgumentError, 'cents must be Numeric' unless number.is_a?(Numeric)
      cents = if number.is_a?(Float)
        raise CoercionError, "#{number} cannot safely be converted into cents" unless number.to_i == number
        number.to_i
      else
        number
      end
      new cents
    end

    alias_method :[], :cents

    def dollars number
      return number if number.is_a?(self)
      raise ArgumentError, 'dollars must be Numeric' unless number.is_a?(Numeric)
      if number != number.round(2)
        raise CoercionError, "#{number} cannot safely be converted into cents"
      end
      cents = (number * 100.00).round
      new cents
    end

    private :new

  end

  def initialize cents
    raise ArgumentError, 'cents must be an Integer' unless cents.is_a?(Integer)
    @cents = cents
    freeze
  end

  def to_i
    @cents
  end

  %w{ hash even? odd? zero? to_f < <= == > >= <=> to_json coerce }.each do |method_name|
    class_eval <<-RUBY, __FILE__, __LINE__ + 1
      def #{method_name}(*args, &block)
        to_i.send(:#{method_name}, *args, &block)
      end
    RUBY
  end

  def eql? other
    other = other.to_i if self.class === other
    to_i.eql?(other)
  end

  def equal? other
    other = other.to_i if self.class === other
    to_i.equal?(other)
  end

  def to_dollars
    (@cents * 0.01).round(2)
  end

  def + number
    self.class.cents( to_i + number )
  rescue CoercionError
    raise ArithmeticError, "#{number} cannot be safely added to #{self}"
  end

  def - number
    self.class.cents( to_i - number )
  rescue CoercionError
    raise ArithmeticError, "#{number} cannot be safely subtracted from #{self}"
  end

  def * number
    self.class.cents( to_f * number )
  rescue CoercionError
    raise ArithmeticError, "#{self} cannot be safely multiplied by #{number}"
  end

  def / number
    self.class.cents( to_f / number )
  rescue CoercionError
    raise ArithmeticError, "#{self} cannot be safely divided by #{number}"
  end

  alias_method :div, :/

  def -@
    self.class.cents(-to_i)
  end

  def positive?
    self > 0
  end

  def negative?
    self < 0
  end

  def inspect
    dollars = to_dollars
    "#{'-' if dollars < 0}$#{sprintf('%.2f', dollars.abs)}"
  end
  alias_method :to_s, :inspect
  alias_method :to_str, :inspect

  def as_json options=nil
    to_i
  end

  def to_param
    to_i.to_s
  end

end

class Numeric
  def dollars
    SafeMoney.dollars(self)
  end
  alias_method :dollar, :dollars
  def cents
    SafeMoney.cents(self)
  end
  alias_method :cent, :cents
end
