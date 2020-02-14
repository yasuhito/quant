# frozen_string_literal: true

require 'test_helper'

require 'quant'
require 'symbo'

module Quant
  class VectorTest
    class BasicVectorTest < ActiveSupport::TestCase
      using Symbo

      include Symbo

      test 'create a column vector' do
        assert_equal [2, 0.5, -3], ColumnVector[2, 0.5, -3].to_a
      end

      test 'create a row vector' do
        assert_equal [1, 0, -PI, 23], RowVector[1, 0, -PI, 23].to_a
      end

      test 'length of a vector' do
        assert_equal √(10), ColumnVector[3, 1].length
      end

      test 'scalar multiplication' do
        a = ColumnVector[3, 1]
        u = (1/a.length * a).simplify

        assert_equal [3 * 10**(-1/2), 10**(-1/2)], u.to_a
        assert_equal 1, u.length
      end

      test 'vector addition' do
        a = ColumnVector[3, 1]
        b = ColumnVector[1, 2]

        assert_equal [4, 3], (a + b).to_a
        assert_equal [4, 3], (b + a).to_a
      end
    end

    class BraKetTest < ActiveSupport::TestCase
      test 'multiply a bra by a ket' do
        assert_equal 10, Bra[3, 1] * Ket[3, 1]
      end

      test 'orthogonal vectors' do
        assert_equal 0, Bra[3, 1] * Ket[-2, 6]
      end
    end

    class SpinTest < ActiveSupport::TestCase
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
end
