# frozen_string_literal: true

require 'symbo/expression'

module Symbo
  # Symbo fraction computation
  class Fraction < Expression
    attr_reader :operands

    # :section: Power Transformation Methods

    # べき乗の低
    #
    #   (1/3).base # => UNDEFINED
    def base
      UNDEFINED
    end

    # べき指数
    #
    #   (1/3).exponent # => UNDEFINED
    def exponent
      UNDEFINED
    end

    # :section: Basic Distributive Transformation Methods

    # 同類項の項部分
    #
    #   (1/3).term # => UNDEFINED
    def term
      UNDEFINED
    end

    # 同類項の定数部分
    #
    #   (1/3).const # => UNDEFINED
    def const
      UNDEFINED
    end

    # :section: Order Relation Methods

    # 交換法則によるオペランド並べ替えに使う順序関係
    #
    # - 相手が定数の場合
    # 大小関係で順序を決定
    #
    #   (1/2).compare(4) # => true
    #   (1/2).compare(5/2) # => true
    #
    # - それ以外の場合
    # 常に true
    #
    #   (1/2).compare(:x + :y) # => true
    #   (1/2).compare(:x * :y) # => true
    #   (1/2).compare(2**:x) # => true
    #   (1/2).compare(Factorial(2)) # => true
    #   (1/2).compare(Function(:f, :x)) # => true
    def compare(other)
      case other
      when Integer
        rational < other
      when Fraction
        rational < other.rational
      else
        true
      end
    end

    # :section: Expression Type Methods

    def fraction?
      true
    end

    def constant?
      true
    end

    # :section:

    def positive?
      Rational(@operands[0], @operands[1]).positive?
    end

    def rational
      Rational @operands[0], @operands[1]
    end

    def numerator
      if @operands.all?(&:integer?)
        rational.numerator
      else
        @operands[0]
      end
    end

    def denominator
      if @operands.all?(&:integer?)
        rational.denominator
      else
        @operands[1]
      end
    end

    def evaluate
      if denominator.zero?
        UNDEFINED
      else
        self
      end
    end

    def simplify_rational_number
      if @operands.all?(&:integer?)
        n = @operands[0]
        d = @operands[1]
        if (n % d).zero?
          iquot n, d
        else
          g = n.gcd(d)
          if d.positive?
            Fraction iquot(n, g), iquot(d, g)
          else
            Fraction iquot(-n, g), iquot(-d, g)
          end
        end
      else
        self
      end
    end

    protected

    def _simplify
      return UNDEFINED if @operands[1].zero?

      self
    end

    private

    def iquot(a, b)
      r = Rational(a, b)
      if r.denominator == 1
        r.numerator
      else
        r
      end
    end
  end
end

def Fraction(*operands) # rubocop:disable Naming/MethodName
  Symbo::Fraction.new(*operands)
end
