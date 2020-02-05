# frozen_string_literal: true

require 'test_helper'
require 'circuit'

class XGateTest < ActiveSupport::TestCase
  test 'X|0> = |1>' do
    circuit = Circuit.new(1)
    state = circuit.x(0).state

    assert_equal [Qubit[1]], state
  end

  test 'X|1> = |0>' do
    circuit = Circuit.new(Qubit[1])
    state = circuit.x(0).state

    assert_equal [Qubit[0]], state
  end

  test 'X|+> = |+>' do
    circuit = Circuit.new(Qubit['+'])
    state = circuit.x(0).state

    assert_equal [Qubit['+']], state
  end

  test 'X|-> = -|->' do
    circuit = Circuit.new(Qubit['-'])
    state = circuit.x(0).state

    assert_equal [Qubit['-'] * -1], state
  end

  test 'X|i> = i|-i>' do
    circuit = Circuit.new(Qubit['i'])
    state = circuit.x(0).state

    assert_equal [Qubit['-i'] * 1i], state
  end

  test 'X|-i> = -i|i>' do
    circuit = Circuit.new(Qubit['-i'])
    state = circuit.x(0).state

    assert_equal [Qubit['i'] * -1i], state
  end
end
