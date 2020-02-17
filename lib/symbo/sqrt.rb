# frozen_string_literal: true

require 'symbo/fraction'
require 'symbo/power'

def Sqrt(operand) # rubocop:disable Naming/MethodName
  Symbo::Power[operand, Symbo::Fraction[1, 2]]
end

alias √ Sqrt
