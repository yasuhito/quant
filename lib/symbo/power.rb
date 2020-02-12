# frozen_string_literal: true

require 'symbo/expression'

module Symbo
  # シンボリックなべき乗
  class Power < Expression
    using Symbo

    # :section: Power Transformation Methods

    # べき乗の低
    #
    #   (:x**2).base # => :x
    def base
      @operands[0]
    end

    # べき指数
    #
    #   (:x**2).exponent # => 2
    def exponent
      @operands[1]
    end

    # :section: Basic Distributive Transformation Methods

    # 同類項の項部分
    #
    #   (:x**2).term # => Product(:x**2)
    def term
      Product(self)
    end

    # 同類項の定数部分
    #
    #   (:x**2).const # => 1
    def const
      1
    end

    # :section: Order Relation Methods

    # 交換法則によるオペランド並べ替えに使う順序関係
    #
    # - 相手がべき乗の場合
    # 底が異なる場合、底同士で順序を決める。
    # 底が等しい場合、べき指数同士で順序を決める。
    #
    #   ((1 + :x)**3).compare((1 + :y)**2) # => true
    #   ((1 + :x)**2).compare((1 + :x)**3) # => true
    #
    # - 和、階乗、関数、シンボルの場合
    # 相手を 1 乗のべき乗に変換して比較
    #
    #   ((1 + :x)**3).compare(1 + :y) # => true
    #
    # - それ以外の場合
    # 次のルールで比較
    #
    #   !other.compare(self)
    def compare(other)
      case other
      when Power
        return base.compare(other.base) if base != other.base

        exponent.compare other.exponent
      when Sum, Factorial, Function, Symbol
        compare Power(other, 1)
      else
        !other.compare(self)
      end
    end

    # :section: Expression Type Methods

    def power?
      true
    end

    # :section:

    def evaluate
      v = base.evaluate
      n = exponent

      if v.numerator != 0
        if n.positive?
          s = Power(v, n - 1).evaluate
          Product(s, v).evaluate
        elsif n.zero?
          1
        elsif n == -1
          raise NotImplementedError
        elsif n < -1
          raise NotImplementedError
        end
      elsif v.numerator.zero?
        if n >= 1
          0
        elsif n <= 0
          UNDEFINED
        end
      end
    end

    protected

    def _simplify
      return UNDEFINED if base == UNDEFINED || exponent == UNDEFINED

      if base.zero?
        return 1 if exponent.positive? && exponent.constant?

        return UNDEFINED
      end

      return 1 if base == 1
      return simplify_integer_power if exponent.integer?

      self
    end

    def simplify_integer_power
      return Power(base, exponent).evaluate.simplify_rational_number if base.constant?
      return 1 if exponent.zero?
      return base if exponent == 1

      case base
      when Power
        r = base.operands[0]
        s = base.operands[1]
        p = Product.new(s, exponent).simplify

        if p.integer?
          Power(r, p).simplify_integer_power
        else
          Power(r, p)
        end
      when Product
        r = base.operands.map { |each| Power(each, exponent).simplify_integer_power }
        Product(*r).simplify
      else
        self
      end
    end
  end
end

def Power(*operands) # rubocop:disable Naming/MethodName
  Symbo::Power.new(*operands)
end
