# frozen_string_literal: true

require 'test_helper'

require 'qubit'
require 'qubits'

# rubocop:disable Metrics/ClassLength
class QubitTest < ActiveSupport::TestCase
  include Math

  test 'convert to bra vector' do
    bra = Qubit[1 + 2i, 2 + 1i].bra

    assert_equal 1, bra.row_size
    assert_equal 2, bra.column_size
    assert_equal 1 - 2i, bra[0, 0]
    assert_equal 2 - 1i, bra[0, 1]
  end

  test 'inner product' do
    ket1 = Qubit[1 + 2i, 2 - 1i, 3]
    ket2 = Qubit[1 + 2i, 4, 2 + 1i]

    assert_equal 19 + 7i, ket1 * ket2
  end

  test 'identity gate' do
    qubits = Qubits[0]
    qubits.i(0)

    assert_equal '|0>', qubits.to_s
  end

  test 'Pauli X gate' do
    qubits = Qubits[0]
    qubits.x(0)

    assert_equal '|1>', qubits.to_s
  end

  test 'Pauli Y gate' do
    qubits = Qubits[0]
    qubits.y(0)

    assert_equal [0, 1i], qubits[0].state
  end

  test 'Pauli Z gate' do
    qubits = Qubits[0]
    qubits.z(0)

    assert_equal [1, 0], qubits[0].state
  end

  test 'Hadamard gate' do
    qubits = Qubits[0]
    qubits.h(0)

    assert_equal [1 / sqrt(2), 1 / sqrt(2)], qubits[0].state
  end

  test 'S phase shift gate |0>' do
    qubits = Qubits[0]
    qubits[0].S

    assert_equal [1, 0], qubits[0].state
  end

  test 'S phase shift gate |1>' do
    qubits = Qubits[1]
    qubits[0].S

    assert_equal [0, 1i], qubits[0].state
  end

  test 'T phase shift gate |0>' do
    qubits = Qubits[0]
    qubits[0].T

    assert_equal [1, 0], qubits[0].state
  end

  test 'T phase shift gate' do
    qubits = Qubits[1]
    qubits[0].T

    assert_equal [0, E**(1i * PI / 4)], qubits[0].state
  end

  test 'Rx rotation gate' do
    qubits = Qubits[0]
    qubits[0].Rx(2 * PI)

    assert_equal [cos(PI), -1i * sin(PI)], qubits[0].state
  end

  test 'Ry rotation gate' do
    qubits = Qubits[0]
    qubits[0].Ry(2 * PI)

    assert_equal [cos(PI), sin(PI)], qubits[0].state
  end

  test 'Rz rotation gate' do
    qubits = Qubits[0]
    qubits[0].Rz(2 * PI)

    assert_equal [E**(-1i * PI), 0], qubits[0].state
  end

  test 'R1 rotation gate' do
    qubits = Qubits[0]
    qubits[0].R1(2 * PI)

    assert_equal [1, 0], qubits[0].state
  end

  test 'CNOT gate |00>' do
    qubits = Qubits[0, 0]
    qubits[1].CNOT(qubits[0])

    assert_equal [1, 0], qubits[0].state
    assert_equal [1, 0], qubits[1].state
  end

  test 'CNOT gate |01>' do
    qubits = Qubits[0, 1]
    qubits[1].CNOT(qubits[0])

    assert_equal [1, 0], qubits[0].state
    assert_equal [0, 1], qubits[1].state
  end

  test 'CNOT gate |10>' do
    qubits = Qubits[1, 0]
    qubits[1].CNOT(qubits[0])

    assert_equal [0, 1], qubits[0].state
    assert_equal [1, 0], qubits[1].state
  end

  test 'CNOT gate |11>' do
    qubits = Qubits[1, 1]
    qubits[1].CNOT(qubits[0])

    assert_equal [0, 1], qubits[0].state
    assert_equal [1, 0], qubits[1].state
  end
end
# rubocop:enable Metrics/ClassLength
