# frozen_string_literal: true

require 'symbo/expression'
require 'symbo/integer'
require 'symbo/symbol'

module Symbo
  class Function < Expression
    using Symbo

    def name
      @operands[0]
    end

    def parameters
      @operands[1..-1]
    end

    # :section: Power Transformation Methods

    # べき乗の低
    #
    #   Function(:f, :x).base # => Function(:f, :x)
    def base
      dup
    end

    # べき指数
    #
    #   Function(:f, :x).exponent # => 1
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
    # - 相手が関数の場合
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
    # - シンボルの場合
    # 関数名とシンボルが等しい場合 false
    #
    #   Function(:f, :x).compare(:f) # => false
    #
    # 異なる場合、関数名とシンボルで比較
    #
    #   Function(:f, :x).compare(:g) # => true
    #
    # - それ以外の場合
    #
    #   u.compare(v) → !v.compare(u)
    def compare(v)
      case v
      when Function
        if name != v.name
          name.compare v.name
        else
          return parameters.first.compare v.parameters.first if parameters.first != v.parameters.first

          m = parameters.length
          n = v.parameters.length
          0.upto([m, n].min - 2) do |j|
            return parameters[j + 1].compare(v.parameters[j + 1]) if (parameters[j] == v.parameters[j]) && (parameters[j + 1] != v.parameters[j + 1])
          end

          m.compare(n)
        end
      when Symbol
        if name == v
          false
        else
          name.compare v
        end
      else
        !v.compare(self)
      end
    end
  end
end

def Function(name, *operands) # rubocop:disable Naming/MethodName
  Symbo::Function.new(*([name] + operands))
end
