# frozen_string_literal: true

require 'test_helper'

require 'i'
require 'multi_qubit'
require 'x'
require 'y'
require 'z'

class MultiQubitTest < ActiveSupport::TestCase
  test 'マルチキュービット (量子ビット1つ) の文字列表現' do
    assert_equal '|0>', MultiQubit[0].to_s
  end

  test 'マルチキュービットの文字列表現' do
    assert_equal '|01>', MultiQubit[0, 1].to_s
  end

  test 'マルチキュービット (量子ビット1つ) の長さ' do
    assert_equal 1, MultiQubit[0].length
  end

  test 'マルチキュービットの長さ' do
    assert_equal 2, MultiQubit[0, 1].length
  end

  test 'ブラベクトルに変換' do
    bra = MultiQubit[Complex(1, 2), Complex(2, 1)].bra

    assert_equal 1, bra.row_size
    assert_equal 2, bra.column_size
    assert_equal Complex(1, -2), bra[0, 0]
    assert_equal Complex(2, -1), bra[0, 1]
  end

  test 'ケットベクトル同士の内積' do
    ket1 = MultiQubit[Complex(1, 2), Complex(2, -1), 3]
    ket2 = MultiQubit[Complex(1, 2), 4, Complex(2, 1)]

    assert_equal Complex(19, 7), ket1 * ket2
  end

  test '単位行列 I' do
    qubit = I * MultiQubit[1, 0]

    assert_equal MultiQubit[1, 0], qubit
  end

  test 'パウリ X ゲート' do
    qubit = X * MultiQubit[1, 0]

    assert_equal MultiQubit[0, 1], qubit
  end

  test 'パウリ Y ゲート' do
    qubit = Y * MultiQubit[1, 0]

    assert_equal MultiQubit[0, Complex(0, 1)], qubit
  end

  test 'パウリ Z ゲート' do
    qubit = Z * MultiQubit[1, 0]

    assert_equal MultiQubit[1, 0], qubit
  end
end
