# frozen_string_literal: true

module Symbolic
  # シンボリックな関数
  class Function
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

    def ==(other)
      @name == other.name && @operands == other.operands
    end
  end
end

def Function(name, *operands) # rubocop:disable Naming/MethodName
  Symbolic::Function.new(name, *operands)
end
