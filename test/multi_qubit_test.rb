# frozen_string_literal: true

require 'test_helper'
require 'multi_qubit'

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
end
