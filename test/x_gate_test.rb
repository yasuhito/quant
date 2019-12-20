# frozen_string_literal: true

require 'test_helper'
require 'circuit'

class XGateTest < ActiveSupport::TestCase
  include Math

  setup do
    @circuit = Circuit.new(1)
  end

  test 'X|0> = |1>' do
    result = @circuit.x(0)

    assert_equal '|1>', result.to_s
  end

  test 'X|1> = |0>' do
    @circuit = @circuit.x(0)
    result = @circuit.x(0)

    assert_equal '|0>', result.to_s
  end

  test 'X|+> = |+>' do
    @circuit = @circuit.h(0)
    result = @circuit.x(0)

    assert_equal '|+>', result.to_s
  end

  test 'X|-> = -|->' do
    @circuit = @circuit.x(0).h(0)
    result = @circuit.x(0)

    assert_equal '|->', result.negate.to_s
  end

  test 'X|i> = i|-i>' do
    @circuit = @circuit.h(0).s(0)
    result = @circuit.x(0)

    assert_equal [[1i / sqrt(2), 1 / sqrt(2)]], result.state
  end

  test 'X|-i> = -i|i>' do
    @circuit = @circuit.x(0).h(0).s(0)
    result = @circuit.x(0)

    assert_equal [[-1i / sqrt(2), 1 / sqrt(2)]], result.state
  end
end
