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

    assert_equal [4, 3], (a + b).simplify.to_a
    assert_equal [4, 3], (b + a).simplify.to_a
  end

  test 'multiply a bra by a ket' do
    a = Ket[3, 1]

    assert_equal 10, (a * a).simplify
  end

  test 'orthogonal vectors' do
    a = Ket[3, 1]
    b = Ket[1, 2]
    c = Ket[-2, 6]

    assert_equal 5, (a * b).simplify
    assert_equal 0, (a * c).simplify
  end
end
