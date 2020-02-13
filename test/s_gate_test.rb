# frozen_string_literal: true

require 'test_helper'
require 'quant/circuit'

class SGateTest < ActiveSupport::TestCase
  test 'S|0> = |0>' do
    circuit = Quant::Circuit.new(1)
    state = circuit.s(0).state

    assert_equal [Qubit[0]], state
  end

  test 'S|1> = i|1>' do
    circuit = Quant::Circuit.new(Qubit[1])
    state = circuit.s(0).state

    assert_equal [Qubit[1] * 1i], state
  end

  test 'S|+> = |i>' do
    circuit = Quant::Circuit.new(Qubit['+'])
    state = circuit.s(0).state

    assert_equal [Qubit['i']], state
  end

  test 'S|-> = |-i>' do
    circuit = Quant::Circuit.new(Qubit['-'])
    state = circuit.s(0).state

    assert_equal [Qubit['-i']], state
  end

  test 'S|i> = |->' do
    circuit = Quant::Circuit.new(Qubit['i'])
    state = circuit.s(0).state

    assert_equal [Qubit['-']], state
  end

  test 'S|-i> = |+>' do
    circuit = Quant::Circuit.new(Qubit['-i'])
    state = circuit.s(0).state

    assert_equal [Qubit['+']], state
  end
end
