# frozen_string_literal: true

require 'symbo/algebraic_operators'
require 'symbo/integer'
require 'symbo/relational_operators'
require 'symbo/symbol'

module Symbo
  UNDEFINED = :undefined

  # General expression interface
  class Expression
    using Symbo

    include AlgebraicOperators
    include ExpressionType
    include RelationalOperators

    attr_reader :operands

    def initialize(*operands)
      @operands = operands
    end

    # :section: Simplification Methods

    def simplify
      self.class.new(*@operands.map(&:simplify))._simplify
    end

    # :section: Power Transformation Methods
    #
    # 自動簡約式 u のべき乗変形に使うオペレータ。
    #
    #   u^v·u^w = u^{v+w}
    #

    # べき乗の低
    def base
      raise NotImplementedError
    end

    # べき指数
    #
    # べき指数を書かない b のような式では exponent → 1 を返すことで、
    #
    #   b·b^2 = b^3
    #
    # のような式変形を簡単にする。
    def exponent
      raise NotImplementedError
    end

    # :section: Basic Distributive Transformation Methods
    #
    # 同類項のまとめに使うオペレータ。
    #
    #   v·u + w·u = (v+w)u
    #

    # 同類項の項部分
    #
    # 返り値は Product または UNDEFINED になる。返り値に単項の積 ·u があるが、
    # これは x と 2x の term を取ったときにどちらも同じ ·x を返すようにするための工夫。
    #
    #   # ·u を返すもの
    #   :x.term # => Product(:x)
    #   (:x + :y).term # => Product(:x + :y)
    #   (:x**2).term # => Product(:x**2)
    #   Factorial(:x).term # => Product(Factorial(:x))
    #   Function(:f, :x).term # => Product(Function(:f, :x))
    #
    #   # 積の項部分を返すもの
    #   Product(2, :x, :y, :z).term # => Product(:x, :y, :z)
    #   Product(1/3, :x, :y, :z).term # => Product(:x, :y, :z)
    #   Product(:x, :y, :z).term # => Product(:x, :y, :z) Product(:x, :y, :z).term
    #
    #   # UNDEFINED
    #   1.term # => UNDEFINED
    #   (1/3).term # => UNDEFINED
    def term
      raise NotImplementedError
    end

    # 同類項の定数部分
    #
    #   # 1 を返すもの
    #   :x.const # => 1
    #   (:x + :y).const # => 1
    #   (:x**2).const # => 1
    #   Factorial(:x).const # => 1
    #   Function(:f, :x).const # => 1
    #
    #   # 積の定数部分を返すもの
    #   Product(2, :x, :y, :z).const # => 2
    #   Product(1/3, :x, :y, :z).const # => 1/3
    #   Product(:x, :y, :z).const # => 1
    #
    #   # UNDEFINED
    #   1.const # => UNDEFINED
    #   (1/3).const # => UNDEFINED
    def const
      raise NotImplementedError
    end

    # :section: Order Relation Methods

    # 交換法則によるオペランド並べ替えに使う順序関係
    def compare(_v)
      raise NotImplementedError
    end

    # :section: Operand Methods

    # Returns nth operand
    def operand(n)
      @operands[n]
    end

    # Returns the number of operands
    def length
      @operands.length
    end

    protected

    # :category: Simplification Methods

    def _simplify
      raise NotImplementedError
    end
  end
end
