# frozen_string_literal: true

require 'test_helper'
require 'circuit'

class SGateTest < ActiveSupport::TestCase
  # test 'S|0> = |0>' do
  #   circuit = Circuit.new(1)
  #   result = circuit.s(0)

  #   assert_equal [Qubit[0]], result.state
  # end

  # test 'S|1> = i|1>' do
  #   circuit = Circuit.new(Qubit[1])
  #   result = circuit.s(0)

  #   assert_equal [Qubit[1] * 1i], result.state
  # end

  # test 'S|+> = |i>' do
  #   circuit = Circuit.new(Qubit['+'])
  #   result = circuit.s(0)

  #   assert_equal [Qubit['i']], result.state
  # end

  # test 'S|-> = |-i>' do
  #   circuit = Circuit.new(Qubit['-'])
  #   result = circuit.s(0)

  #   assert_equal [Qubit['-i']], result.state
  # end

  # test 'S|i> = |->' do
  #   circuit = Circuit.new(Qubit['i'])
  #   result = circuit.s(0)

  #   assert_equal [Qubit['-']], result.state
  # end

  # test 'S|-i> = |+>' do
  #   circuit = Circuit.new(Qubit['-i'])
  #   result = circuit.s(0)

  #   assert_equal [Qubit['+']], result.state
  # end
end
