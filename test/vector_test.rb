# frozen_string_literal: true

require 'test_helper'

require 'symbo'
require 'quant/bra'
require 'quant/ket'

module Quant
  class VectorTest < ActiveSupport::TestCase
    using Symbo

    include Symbo

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

    test '<↑|↑> = 1' do
      assert_equal 1, Bra['↑'] * Ket['↑']
    end

    test '<↓|↓> = 1' do
      assert_equal 1, Bra['↓'] * Ket['↓']
    end

    test '<↑|↓> = 0' do
      assert_equal 0, Bra['↑'] * Ket['↓']
    end

    test '<↓|↑> = 0' do
      assert_equal 0, Bra['↓'] * Ket['↑']
    end

    test '<→|→> = 1' do
      assert_equal 1, Bra['→'] * Ket['→']
    end

    test '<←|←> = 1' do
      assert_equal 1, Bra['←'] * Ket['←']
    end

    test '<→|←> = 0' do
      assert_equal 0, Bra['→'] * Ket['←']
    end

    test '<←|→> = 0' do
      assert_equal 0, Bra['←'] * Ket['→']
    end

    test '<↗|↗> = 1' do
      assert_equal 1, Bra['↗'] * Ket['↗']
    end

    test '<↙|↙> = 1' do
      assert_equal 1, Bra['↙'] * Ket['↙']
    end

    test '<↗|↙> = 0' do
      assert_equal 0, Bra['↗'] * Ket['↙']
    end

    test '<↙|↗> = 0' do
      assert_equal 0, Bra['↙'] * Ket['↗']
    end
  end
end
