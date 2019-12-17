# frozen_string_literal: true

require 'test_helper'
require 'qubit'

class QubitTest < ActiveSupport::TestCase
  test '量子ビットを観測するとデフォルトで 0' do
    qubit = Qubit.new
    assert_equal 0, qubit.measure
  end
end
