# frozen_string_literal: true

require 'test_helper'
require 'circuit'

class YGateTest < ActiveSupport::TestCase
  test 'Y|0> = i|1>' do
    circuit = Circuit.new(1)
    result = circuit.y(0)

    assert_equal [Qubit[1] * 1i], result.state
  end

  test 'Y|1> = -i|0>' do
    circuit = Circuit.new(Qubit[1])
    result = circuit.y(0)

    assert_equal [Qubit[0] * -1i], result.state
  end

  test 'Y|+> = -i|->' do
    circuit = Circuit.new(Qubit['+'])
    result = circuit.y(0)

    assert_equal [Qubit['-'] * -1i], result.state
  end

  test 'Y|-> = i|+>' do
    circuit = Circuit.new(Qubit['-'])
    result = circuit.y(0)

    assert_equal [Qubit['+'] * 1i], result.state
  end

  test 'Y|i> = |i>' do
    circuit = Circuit.new(Qubit['i'])
    result = circuit.y(0)

    assert_equal [Qubit['i']], result.state
  end

  test 'Y|-i> = -|-i>' do
    circuit = Circuit.new(Qubit['-i'])
    result = circuit.y(0)

    assert_equal [Qubit['-i'] * -1], result.state
  end
end
