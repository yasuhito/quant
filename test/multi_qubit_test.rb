# frozen_string_literal: true

require 'test_helper'

require 'h'
require 'i'
require 'multi_qubit'
require 's'
require 't'
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
    bra = MultiQubit[1 + 2i, 2 + 1i].bra

    assert_equal 1, bra.row_size
    assert_equal 2, bra.column_size
    assert_equal 1 - 2i, bra[0, 0]
    assert_equal 2 - 1i, bra[0, 1]
  end

  test 'ケットベクトル同士の内積' do
    ket1 = MultiQubit[1 + 2i, 2 - 1i, 3]
    ket2 = MultiQubit[1 + 2i, 4, 2 + 1i]

    assert_equal 19 + 7i, ket1 * ket2
  end

  test '単位行列 I' do
    qubit = I(MultiQubit[1, 0])

    assert_equal MultiQubit[1, 0], qubit
  end

  test 'パウリ X ゲート' do
    qubit = X(MultiQubit[1, 0])

    assert_equal MultiQubit[0, 1], qubit
  end

  test 'パウリ Y ゲート' do
    qubit = Y(MultiQubit[1, 0])

    assert_equal MultiQubit[0, 1i], qubit
  end

  test 'パウリ Z ゲート' do
    qubit = Z(MultiQubit[1, 0])

    assert_equal MultiQubit[1, 0], qubit
  end

  test 'アダマールゲート' do
    qubit = H(MultiQubit[1, 0])

    assert_equal MultiQubit[1 / Math.sqrt(2), 1 / Math.sqrt(2)], qubit
  end

  test 'フェーズシフトゲート S' do
    assert_equal MultiQubit[1, 0], S(MultiQubit[1, 0])
    assert_equal MultiQubit[0, 1i], S(MultiQubit[0, 1])
  end

  test 'フェーズシフトゲート T' do
    assert_equal MultiQubit[1, 0], T(MultiQubit[1, 0])
    assert_equal MultiQubit[0, Math::E**(1i * Math::PI / 4)], T(MultiQubit[0, 1])
  end
end
