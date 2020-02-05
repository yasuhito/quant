# frozen_string_literal: true

require 'test_helper'
require 'circuit'

class ZGateTest < ActiveSupport::TestCase
  test 'Z|0> = |0>' do
    circuit = Circuit.new(1)
    state = circuit.z(0).state

    assert_equal [Qubit[0]], state
  end

  test 'Z|1> = -|1>' do
    circuit = Circuit.new(Qubit[1])
    state = circuit.z(0).state

    assert_equal [Qubit[1] * -1], state
  end

  test 'Z|+> = |->' do
    circuit = Circuit.new(Qubit['+'])
    state = circuit.z(0).state

    assert_equal [Qubit['-']], state
  end

  test 'Z|-> = |+>' do
    circuit = Circuit.new(Qubit['-'])
    state = circuit.z(0).state

    assert_equal [Qubit['+']], state
  end

  test 'Z|i> = |-i>' do
    circuit = Circuit.new(Qubit['i'])
    state = circuit.z(0).state

    assert_equal [Qubit['-i']], state
  end

  test 'Z|-i> = |i>' do
    circuit = Circuit.new(Qubit['-i'])
    state = circuit.z(0).state

    assert_equal [Qubit['i']], state
  end
end
