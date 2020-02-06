# frozen_string_literal: true

require 'symbo/integer'
require 'symbo/symbol'

module Symbo
  # シンボリックな関数
  class Function
    using Symbo

    attr_reader :name
    attr_reader :operands

    def initialize(name, *operands)
      @name = name
      @operands = operands
    end

    # :section: Power Transformation Methods

    # See Symbo::Expression#base
    def base
      dup
    end

    # See Symbo::Expression#exponent
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
    # == 相手が関数の場合
    # 関数名が異なる場合、関数名で順序を決定。
    #
    #   Function(:f, :x).compare(Function(:g, :x)) # => true
    #
    # 関数名が同じの場合、関数の最左のオペランドから順に compare していき、
    # 異なるものがあればそれで順序を決定する。
    #
    #   Function(:f, :x).compare(Function(:f, :y)) # => true
    #
    # どちらかのオペランドがなくなれば、短いほうが左側。
    #
    #   Function(:g, :x).compare(Function(:g, :x, :y)) # => true
    #
    # == シンボルの場合
    # 関数名とシンボルが等しい場合 false
    #
    #   Function(:f, :x).compare(:f) # => false
    #
    # 異なる場合、関数名とシンボルで比較
    #
    #   Function(:f, :x).compare(:g) # => true
    #
    # == それ以外の場合
    #
    #   u.compare(v) → !v.compare(u)
    def compare(v)
      case v
      when Function
        if @name != v.name
          @name.compare v.name
        else
          return @operands.first.compare v.operands.first if @operands.first != v.operands.first

          m = @operands.size
          n = v.operands.size
          if [m, n].min >= 1
            0.upto([m, n].min - 2) do |j|
              return @operands[j + 1].compare(v.operands[j + 1]) if (@operands[j] == v.operands[j]) && (@operands[j + 1] != v.operands[j + 1])
            end

            m.compare(n)
          end
        end
      when Symbol
        if @name == v
          false
        else
          @name.compare v
        end
      else
        !v.compare(self)
      end
    end

    # :section:

    def ==(other)
      @name == other.name && @operands == other.operands
    end
  end
end

def Function(name, *operands) # rubocop:disable Naming/MethodName
  Symbo::Function.new(name, *operands)
end
