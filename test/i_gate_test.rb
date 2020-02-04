# frozen_string_literal: true

require 'test_helper'

require 'circuit'

class IGateTest < ActiveSupport::TestCase
  using Symbo

  test 'I|0> = |0>' do
    circuit = Circuit.new(1)

    assert_equal [Qubit[0]], circuit.i(0).state
  end

  test 'I|1> = |1>' do
    circuit = Circuit.new(Qubit[1])

    assert_equal [Qubit[1]], circuit.i(0).state
  end

  # test 'I|+> = |+>' do
  #   circuit = Circuit.new(Qubit['+'])

  #   assert_equal [Qubit['+']], circuit.i(0).state
  # end

  # test 'I|-> = |->' do
  #   circuit = Circuit.new(Qubit['-'])
  #   result = circuit.i(0)

  #   assert_equal [Qubit['-']], result.state
  # end

  # test 'I|i> = |i>' do
  #   circuit = Circuit.new(Qubit['i'])
  #   result = circuit.i(0)

  #   assert_equal [Qubit['i']], result.state
  # end

  # test 'I|-i> = |-i>' do
  #   circuit = Circuit.new(Qubit['-i'])
  #   result = circuit.i(0)

  #   assert_equal [Qubit['-i']], result.state
  # end
end
