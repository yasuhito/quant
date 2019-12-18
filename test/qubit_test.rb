# frozen_string_literal: true

require 'test_helper'

require 'h'
require 'i'
require 'qubit'
require 'r'
require 's'
require 't'
require 'x'
require 'y'
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
    qubit = I(Qubit[1, 0])

    assert_equal Qubit[1, 0], qubit
  end

  test 'Pauli X gate' do
    qubit = X(Qubit[1, 0])

    assert_equal Qubit[0, 1], qubit
  end

  test 'Pauli Y gate' do
    qubit = Y(Qubit[1, 0])

    assert_equal Qubit[0, 1i], qubit
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
end
