# frozen_string_literal: true

module Quant
  class MatrixTest < ActiveSupport::TestCase
    using Symbo

    test 'matrix multiplication' do
      a1 = Bra[1, -4, 2]
      a2 = Bra[2, 3, 0]
      a = Matrix[a1, a2]

      b1 = Ket[1, 7, 6]
      b2 = Ket[2, 5, 1]
      b = Matrix.columns([b1, b2])

      assert_equal Matrix[[-15, -16], [23, 19]], a * b
    end

    test 'rewrite |↑> in terms of an orthonormal basis |→> and <←|' do
      a = Matrix.columns([Ket['→'], Ket['←']])
      pamp = a.t * Ket['↑']

      assert_equal 1, pamp.column_size
      assert_equal 2, pamp.row_size
      assert_equal (1/√(2)).simplify, pamp[0, 0]
      assert_equal 1/√(2), pamp[1, 0]
    end
  end
end
