# frozen_string_literal: true

require 'test_helper'

require 'quant/circuit'

module Quant
  class R1GateTest < ActiveSupport::TestCase
    include Symbo

    using Symbo

    test 'R1|0>' do
      circuit = Circuit.new(1).r1(0, theta: 2 * PI)

      assert_equal [[1, 0]], circuit.state
    end

    test 'R1|1>' do
      circuit = Circuit.new(1).x(0).r1(0, theta: 2 * PI)

      assert_equal [[0, (E**(2i * PI)).simplify]], circuit.state
    end
  end
end
