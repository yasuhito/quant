# frozen_string_literal: true

require 'test_helper'
require 'qubit'

class QubitTest < ActiveSupport::TestCase
  setup do
    @qubit = Qubit.new
  end

  test '量子ビット 0 を観測' do
    assert_equal 0, @qubit.measure
  end

  test '量子ビット 0 の文字列表現' do
    assert_equal '|0>', @qubit.to_s
  end
end
