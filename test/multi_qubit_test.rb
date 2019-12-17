# frozen_string_literal: true

require 'test_helper'
require 'multi_qubit'

class MultiQubitTest < ActiveSupport::TestCase
  test 'マルチキュービット (量子ビット1つ) の文字列表現' do
    multi_qubit = MultiQubit.new(0)
    assert_equal '|0>', multi_qubit.to_s
  end

  test 'マルチキュービットの文字列表現' do
    multi_qubit = MultiQubit.new(0, 1)
    assert_equal '|01>', multi_qubit.to_s
  end

  test 'マルチキュービット (量子ビット1つ) の長さ' do
    multi_qubit = MultiQubit.new(0)
    assert_equal 1, multi_qubit.length
  end

  test 'マルチキュービットの長さ' do
    multi_qubit = MultiQubit.new(0, 1)
    assert_equal 2, multi_qubit.length
  end
end
