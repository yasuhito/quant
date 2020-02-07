# frozen_string_literal: true

require 'symbo/integer'
require 'symbo/symbol'

module Symbo
  # シンボリックな階乗
  class Factorial < Expression
    using Symbo

    attr_reader :operands

    def initialize(*operands)
      @operands = operands
    end

    # :section: Power Transformation Methods

    # べき乗の低
    #
    #   Factorial(:x).base # => Factorial(:x)
    def base
      dup
    end

    # べき指数
    #
    #   Factorial(:x).exponent # => 1
    def exponent
      1
    end

    # :section: Basic Distributive Transformation Methods

    # See Symbo::Expression#term
    def term
      Product(self)
    end

    # See Symbo::Expression#const
    def const
      1
    end

    # :section: Order Relation Methods

    # 交換法則によるオペランド並べ替えに使う順序関係
    #
    # - 相手が階乗の場合
    # オペランド同士を比較する
    #
    #   Factorial(:m).compare(:n) # => true
    #
    # - 関数またはシンボルの場合
    # 最初のオペランドが相手と同じ場合 false
    #
    #   Factorial(Function(:f, :x)).compare(Function(:f, :x)) # => false
    #   Factorial(:x).compare(:x) # => true
    #
    # 異なる場合、相手を階乗と見て比較
    #
    #   Factorial(:x).compare(Function(:f, :x)) # => true
    #
    # - それ以外の場合
    #
    #   u.compare(v) → !v.compare(u)
    def compare(v)
      case v
      when Factorial
        @operands[0].compare v.operands[0]
      when Function, Symbol
        if @operands[0] == v
          false
        else
          compare Factorial(v)
        end
      else
        !v.compare(self)
      end
    end
  end
end

def Factorial(*operands) # rubocop:disable Naming/MethodName
  Symbo::Factorial.new(*operands)
end
