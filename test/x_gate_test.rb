# frozen_string_literal: true

require 'test_helper'
require 'circuit'

class XGateTest < ActiveSupport::TestCase
  # test 'X|0> = |1>' do
  #   circuit = Circuit.new(1)
  #   result = circuit.x(0)

  #   assert_equal [Qubit[1]], result.state
  # end

  # test 'X|1> = |0>' do
  #   circuit = Circuit.new(Qubit[1])
  #   result = circuit.x(0)

  #   assert_equal [Qubit[0]], result.state
  # end

  # test 'X|+> = |+>' do
  #   circuit = Circuit.new(Qubit['+'])
  #   result = circuit.x(0)

  #   assert_equal [Qubit['+']], result.state
  # end

  # test 'X|-> = -|->' do
  #   circuit = Circuit.new(Qubit['-'])
  #   result = circuit.x(0)

  #   assert_equal [Qubit['-'] * -1], result.state
  # end

  # test 'X|i> = i|-i>' do
  #   circuit = Circuit.new(Qubit['i'])
  #   result = circuit.x(0)

  #   assert_equal [Qubit['-i'] * 1i], result.state
  # end

  # test 'X|-i> = -i|i>' do
  #   circuit = Circuit.new(Qubit['-i'])
  #   result = circuit.x(0)

  #   assert_equal [Qubit['i'] * -1i], result.state
  # end
end
