# frozen_string_literal: true

module Quant
  class MatrixTest < ActiveSupport::TestCase
    test 'matrix multiplication' do
      a1 = Bra[1, -4, 2]
      a2 = Bra[2, 3, 0]
      a = Matrix[a1, a2]

      b1 = Ket[1, 7, 6]
      b2 = Ket[2, 5, 1]
      b = Matrix.columns([b1, b2])

      assert_equal Matrix[[-15, -16], [23, 19]], a * b
    end
  end
end
