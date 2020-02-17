# frozen_string_literal: true

require 'symbo/fraction'
require 'symbo/power'

module Symbo
  class Sqrt
    def self.[](x)
      Symbo::Power[x, Symbo::Fraction[1, 2]]
    end
  end

  # rubocop:disable Naming/MethodName, Naming/BinaryOperatorParameterName
  def √(x)
    Sqrt[x]
  end
  # rubocop:enable Naming/MethodName, Naming/BinaryOperatorParameterName
end
