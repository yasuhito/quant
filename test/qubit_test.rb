# frozen_string_literal: true

require 'test_helper'

require 'qubit'

class QubitTest < ActiveSupport::TestCase
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
end
