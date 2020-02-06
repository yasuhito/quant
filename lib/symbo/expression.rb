# frozen_string_literal: true

require 'symbo/integer'
require 'symbo/symbol'
require 'symbo/binary_operation'

module Symbo
  UNDEFINED = :undefined

  # General expression interface
  class Expression
    using Symbo

    include BinaryOperation

    attr_reader :operands

    def initialize(*operands)
      @operands = operands
    end

    def simplify
      self.class.new(*@operands.map(&:simplify))._simplify
    end

    # :section: Power Transformation Methods
    #
    # 定数でない自動簡約式 u のべき乗変形に使うオペレータ。
    #
    #   u^v·u^w = u^{v+w}
    #

    # べき乗の低
    #
    #   # それ自体を返すもの
    #   :x.base # => :x
    #   (:x * :y).base # => :x * :y
    #   (:x + :y).base # => :x + :y
    #   Factorial(:x).base # => Factorial(:x)
    #   Function(:f, :x).base # => Function(:f, :x)
    #
    #   # べき乗
    #   (:x**2).base # => :x
    #
    #   # 定数
    #   1.base # => UNDEFINED
    #   (1/3).base # => UNDEFINED
    def base
      raise NotImplementedError
    end

    # べき乗のべき指数
    #
    # 特に、べき指数のない式 b の exponent は 1 を返すことで、
    #
    #   b·b^2 = b^3
    #
    # のような式変形を簡単にする。
    #
    #   # 1 を返すもの
    #   :x.exponent # => 1
    #   (:x * :y).exponent # => 1
    #   (:x + :y).exponent # => 1
    #   Factorial(:x).exponent # => 1
    #   Function(:f, :x).exponent # => 1
    #
    #   # べき乗
    #   (:x**2).exponent # => 2
    #
    #   # 定数
    #   1.exponent # => UNDEFINED
    #   (1/3).exponent # => UNDEFINED
    def exponent
      raise NotImplementedError
    end

    # :section:

    def term
      raise NotImplementedError
    end

    def const
      raise NotImplementedError
    end

    def compare(_v)
      raise NotImplementedError
    end

    def length
      @operands.length
    end

    def [](n)
      @operands[n]
    end

    def constant?
      false
    end

    def product?
      false
    end

    def integer?
      false
    end

    def zero?
      false
    end

    protected

    def _simplify
      raise NotImplementedError
    end
  end
end
