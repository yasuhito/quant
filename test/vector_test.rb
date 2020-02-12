# frozen_string_literal: true

require 'test_helper'

require 'symbo'

class VectorTest < ActiveSupport::TestCase
  include Symbo
  using Symbo

  test 'create a column vector' do
    assert_equal [2, 0.5, -3], ColumnVector[2, 0.5, -3].to_a
  end

  test 'create a row vector' do
    assert_equal [1, 0, -PI, 23], RowVector[1, 0, -PI, 23].to_a
  end

  test 'length of vector' do
    a = ColumnVector[3, 1]

    assert_equal √(10), a.length
  end

  test 'scalar multiplication' do
    a = ColumnVector[3, 1]
    u = (Fraction(1, a.length) * a).simplify

    assert_equal [Fraction(3, √(10)), Fraction(1, √(10))], u.to_a
    assert_equal 1, u.length
  end

  test 'vector addition' do
    a = ColumnVector[3, 1]
    b = ColumnVector[1, 2]

    assert_equal [4, 3], (a + b).to_a
    assert_equal [4, 3], (b + a).to_a
  end

  test 'multiply a bra by a ket' do
    bra = Bra[3, 1]
    ket = Ket[3, 1]

    assert_equal 10, bra * ket
  end

  test 'orthogonal vectors' do
    a = Bra[3, 1]
    b = Ket[1, 2]
    c = Ket[-2, 6]

    assert_equal 5, a * b
    assert_equal 0, a * c
  end

  test 'R^2 standard basis' do
    b1 = ColumnVector[1, 0]
    b2 = ColumnVector[0, 1]

    assert_equal 1, b1.bra * b1.ket
    assert_equal 1, b2.bra * b2.ket
    assert_equal 0, b1.bra * b2.ket
  end

  test 'orthonormal base #1' do
    b1 = ColumnVector[1/√(2), 1/√(2)]
    b2 = ColumnVector[-1/√(2), 1/√(2)]

    assert_equal 1, b1.bra * b1.ket
    assert_equal 1, b2.bra * b2.ket
    assert_equal 0, b1.bra * b2.ket
  end

  test 'orthonormal base #2' do
    c1 = ColumnVector[1/2, √(3)/2]
    c2 = ColumnVector[-√(3)/2, 1/2]

    assert_equal 1, c1.bra * c1.ket
    assert_equal 1, c2.bra * c2.ket
    assert_equal 0, c1.bra * c2.ket
  end
end
