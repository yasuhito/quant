# frozen_string_literal: true

require 'test_helper'
require 'circuit'

class ZGateTest < ActiveSupport::TestCase
  # test 'Z|0> = |0>' do
  #   circuit = Circuit.new(1)
  #   result = circuit.z(0)

  #   assert_equal [Qubit[0]], result.state
  # end

  # test 'Z|1> = -|1>' do
  #   circuit = Circuit.new(Qubit[1])
  #   result = circuit.z(0)

  #   assert_equal [Qubit[1] * -1], result.state
  # end

  # test 'Z|+> = |->' do
  #   circuit = Circuit.new(Qubit['+'])
  #   result = circuit.z(0)

  #   assert_equal [Qubit['-']], result.state
  # end

  # test 'Z|-> = |+>' do
  #   circuit = Circuit.new(Qubit['-'])
  #   result = circuit.z(0)

  #   assert_equal [Qubit['+']], result.state
  # end

  # test 'Z|i> = |-i>' do
  #   circuit = Circuit.new(Qubit['i'])
  #   result = circuit.z(0)

  #   assert_equal [Qubit['-i']], result.state
  # end

  # test 'Z|-i> = |i>' do
  #   circuit = Circuit.new(Qubit['-i'])
  #   result = circuit.z(0)

  #   assert_equal [Qubit['i']], result.state
  # end
end
