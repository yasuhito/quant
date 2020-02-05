# frozen_string_literal: true

require 'test_helper'
require 'circuit'

class YGateTest < ActiveSupport::TestCase
  test 'Y|0> = i|1>' do
    circuit = Circuit.new(1)
    state = circuit.y(0).state

    assert_equal [Qubit[1] * 1i], state
  end

  test 'Y|1> = -i|0>' do
    circuit = Circuit.new(Qubit[1])
    state = circuit.y(0).state

    assert_equal [Qubit[0] * -1i], state
  end

  test 'Y|+> = -i|->' do
    circuit = Circuit.new(Qubit['+'])
    state = circuit.y(0).state

    assert_equal [Qubit['-'] * -1i], state
  end

  test 'Y|-> = i|+>' do
    circuit = Circuit.new(Qubit['-'])
    state = circuit.y(0).state

    assert_equal [Qubit['+'] * 1i], state
  end

  test 'Y|i> = |i>' do
    circuit = Circuit.new(Qubit['i'])
    state = circuit.y(0).state

    assert_equal [Qubit['i']], state
  end

  test 'Y|-i> = -|-i>' do
    circuit = Circuit.new(Qubit['-i'])
    state = circuit.y(0).state

    assert_equal [Qubit['-i'] * -1], state
  end
end
