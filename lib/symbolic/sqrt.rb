# frozen_string_literal: true

require 'symbolic/fraction'
require 'symbolic/power'

def Sqrt(operand) # rubocop:disable Naming/MethodName
  Power(operand, Fraction(1, 2))
end
