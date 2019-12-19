# frozen_string_literal: true

require 'test_helper'

require 'qubits'

class QubitsTest < ActiveSupport::TestCase
  include Math

  test 'I|0>' do
    qubits = Qubits[0]
    qubits.i(0)

    assert_equal '|0>', qubits.to_s
  end

  test 'X|0>' do
    qubits = Qubits[0]
    qubits.x(0)

    assert_equal '|1>', qubits.to_s
  end

  test 'Y|0>' do
    qubits = Qubits[0]
    qubits.y(0)

    assert_equal [0, 1i], qubits[0].state
  end

  test 'Z|0>' do
    qubits = Qubits[0]
    qubits.z(0)

    assert_equal [1, 0], qubits[0].state
  end

  test 'H|0>' do
    qubits = Qubits[0]
    qubits.h(0)

    assert_equal [1 / sqrt(2), 1 / sqrt(2)], qubits[0].state
  end

  test 'S|0>' do
    qubits = Qubits[0]
    qubits.s(0)

    assert_equal [1, 0], qubits[0].state
  end

  test 'S|1>' do
    qubits = Qubits[1]
    qubits.s(0)

    assert_equal [0, 1i], qubits[0].state
  end

  test 'T|0>' do
    qubits = Qubits[0]
    qubits.t(0)

    assert_equal [1, 0], qubits[0].state
  end

  test 'T|1>' do
    qubits = Qubits[1]
    qubits.t(0)

    assert_equal [0, E**(1i * PI / 4)], qubits[0].state
  end

  test 'Rx|0>' do
    qubits = Qubits[0]
    qubits.rx(0, 2 * PI)

    assert_equal [cos(PI), -1i * sin(PI)], qubits[0].state
  end

  test 'Ry|0>' do
    qubits = Qubits[0]
    qubits.ry(0, 2 * PI)

    assert_equal [cos(PI), sin(PI)], qubits[0].state
  end

  test 'Rz|0>' do
    qubits = Qubits[0]
    qubits.rz(0, 2 * PI)

    assert_equal [E**(-1i * PI), 0], qubits[0].state
  end

  test 'R1|0>' do
    qubits = Qubits[0]
    qubits.r1(0, 2 * PI)

    assert_equal [1, 0], qubits[0].state
  end

  test 'CNOT gate |00>' do
    qubits = Qubits[0, 0]
    qubits.cnot(control: 0, target: 1)

    assert_equal [1, 0], qubits[0].state
    assert_equal [1, 0], qubits[1].state
  end

  test 'CNOT gate |01>' do
    qubits = Qubits[0, 1]
    qubits.cnot(control: 0, target: 1)

    assert_equal [1, 0], qubits[0].state
    assert_equal [0, 1], qubits[1].state
  end

  test 'CNOT gate |10>' do
    qubits = Qubits[1, 0]
    qubits.cnot(control: 0, target: 1)

    assert_equal [0, 1], qubits[0].state
    assert_equal [1, 0], qubits[1].state
  end

  test 'CNOT gate |11>' do
    qubits = Qubits[1, 1]
    qubits.cnot(control: 0, target: 1)

    assert_equal [0, 1], qubits[0].state
    assert_equal [1, 0], qubits[1].state
  end
end
