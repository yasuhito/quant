# frozen_string_literal: true

require 'test_helper'

require 'circuit'

class CircuitTest < ActiveSupport::TestCase
  include Math

  test 'I|0>' do
    circuit = Circuit.new(1).i(0)

    assert_equal '|0>', circuit.to_s
  end

  test 'X|0>' do
    circuit = Circuit.new(1).x(0)

    assert_equal '|1>', circuit.to_s
  end

  test 'Y|0>' do
    circuit = Circuit.new(1).y(0)

    assert_equal [[0, 1i]], circuit.state
  end

  test 'Z|0>' do
    circuit = Circuit.new(1).z(0)

    assert_equal [[1, 0]], circuit.state
  end

  test 'H|0>' do
    circuit = Circuit.new(1).h(0)

    assert_equal [[1 / sqrt(2), 1 / sqrt(2)]], circuit.state
  end

  test 'S|0>' do
    circuit = Circuit.new(1).s(0)

    assert_equal [[1, 0]], circuit.state
  end

  test 'S|1>' do
    circuit = Circuit.new(1).x(0).s(0)

    assert_equal [[0, 1i]], circuit.state
  end

  test 'T|0>' do
    circuit = Circuit.new(1).t(0)

    assert_equal [[1, 0]], circuit.state
  end

  test 'T|1>' do
    circuit = Circuit.new(1).x(0).t(0)

    assert_equal [[0, E**(1i * PI / 4)]], circuit.state
  end

  test 'Rx|0>' do
    circuit = Circuit.new(1).rx(0, 2 * PI)

    assert_equal [[cos(PI), -1i * sin(PI)]], circuit.state
  end

  test 'Ry|0>' do
    circuit = Circuit.new(1).ry(0, 2 * PI)

    assert_equal [[cos(PI), sin(PI)]], circuit.state
  end

  test 'Rz|0>' do
    circuit = Circuit.new(1).rz(0, 2 * PI)

    assert_equal [[E**(-1i * PI), 0]], circuit.state
  end

  test 'R1|0>' do
    circuit = Circuit.new(1).r1(0, 2 * PI)

    assert_equal [[1, 0]], circuit.state
  end

  test 'CNOT gate |00>' do
    circuit = Circuit.new(2).cnot(1, control: 0)

    assert_equal [[1, 0], [1, 0]], circuit.state
  end

  test 'CNOT gate |01>' do
    circuit = Circuit.new(2).x(1).cnot(1, control: 0)

    assert_equal [[1, 0], [0, 1]], circuit.state
  end

  test 'CNOT gate |10>' do
    circuit = Circuit.new(2).x(0).cnot(1, control: 0)

    assert_equal [[0, 1], [1, 0]], circuit.state
  end

  test 'CNOT gate |11>' do
    circuit = Circuit.new(2).x(0).x(1).cnot(1, control: 0)

    assert_equal [[0, 1], [1, 0]], circuit.state
  end
end
