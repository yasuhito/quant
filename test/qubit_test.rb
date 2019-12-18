# frozen_string_literal: true

require 'test_helper'

require 'cnot'
require 'h'
require 'qubit'
require 'qubits'
require 'r'
require 's'
require 't'
require 'z'

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
    qubits[0].I

    assert_equal '|0>', qubits.to_s
  end

  test 'Pauli X gate' do
    qubits = Qubits[0]
    qubits[0].X

    assert_equal '|1>', qubits.to_s
  end

  test 'Pauli Y gate' do
    qubits = Qubits[0]
    qubits[0].Y

    assert_equal [0, 1i], qubits[0].state
  end

  test 'Pauli Z gate' do
    qubit = Z(Qubit[1, 0])

    assert_equal Qubit[1, 0], qubit
  end

  test 'Hadamard gate' do
    qubit = H(Qubit[1, 0])

    assert_equal Qubit[1 / sqrt(2), 1 / sqrt(2)], qubit
  end

  test 'S phase shift gate' do
    assert_equal Qubit[1, 0], S(Qubit[1, 0])
    assert_equal Qubit[0, 1i], S(Qubit[0, 1])
  end

  test 'T phase shift gate' do
    assert_equal Qubit[1, 0], T(Qubit[1, 0])
    assert_equal Qubit[0, E**(1i * PI / 4)], T(Qubit[0, 1])
  end

  test 'Rx rotation gate' do
    qubit = Rx(2 * PI, Qubit[1, 0])

    assert_equal Qubit[cos(PI), -1i * sin(PI)], qubit
  end

  test 'Ry rotation gate' do
    qubit = Ry(2 * PI, Qubit[1, 0])

    assert_equal Qubit[cos(PI), sin(PI)], qubit
  end

  test 'Rz rotation gate' do
    qubit = Rz(2 * PI, Qubit[1, 0])

    assert_equal Qubit[E**(-1i * PI), 0], qubit
  end

  test 'R1 rotation gate' do
    qubit = R1(2 * PI, Qubit[1, 0])

    assert_equal Qubit[1, 0], qubit
  end

  test 'CNOT gate |00>' do
    qubits = Qubits[0, 0]
    result = CNOT(qubits[0], qubits[1])

    assert_equal Qubit[1, 0], result[0]
    assert_equal Qubit[1, 0], result[1]
  end

  test 'CNOT gate |01>' do
    qubits = Qubits[0, 1]
    result = CNOT(qubits[0], qubits[1])

    assert_equal Qubit[1, 0], result[0]
    assert_equal Qubit[0, 1], result[1]
  end

  test 'CNOT gate |10>' do
    qubits = Qubits[1, 0]
    result = CNOT(qubits[0], qubits[1])

    assert_equal Qubit[0, 1], result[0]
    assert_equal Qubit[0, 1], result[1]
  end

  test 'CNOT gate |11>' do
    qubits = Qubits[1, 1]
    result = CNOT(qubits[0], qubits[1])

    assert_equal Qubit[0, 1], result[0]
    assert_equal Qubit[1, 0], result[1]
  end
end
