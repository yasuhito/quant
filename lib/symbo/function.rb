# frozen_string_literal: true

require 'symbo/refinement/integer'
require 'symbo/refinement/symbol'

module Symbo
  # シンボリックな関数
  class Function
    using Symbo::Refinement

    attr_reader :name
    attr_reader :operands

    def initialize(name, *operands)
      @name = name
      @operands = operands
    end

    def base
      self
    end

    def exponent
      1
    end

    def term
      Product(self)
    end

    def const
      1
    end

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
      end
    end

    def ==(other)
      @name == other.name && @operands == other.operands
    end
  end
end

def Function(name, *operands) # rubocop:disable Naming/MethodName
  Symbo::Function.new(name, *operands)
end
