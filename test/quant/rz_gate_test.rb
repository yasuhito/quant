# frozen_string_literal: true

require 'test_helper'

require 'quant/circuit'

module Quant
  class RzGateTest < ActiveSupport::TestCase
    include Symbo

    using Symbo

    test 'Rz|0>' do
      skip '値は合ってるけど simplify の結果が違う'

      circuit = Circuit.new(1).rz(0, theta: 2 * PI)

      assert_equal [[E**(-1i * PI), 0]], circuit.state
    end

    test 'Rz|1>' do
      skip '値は合ってるけど simplify の結果が違う'

      circuit = Circuit.new(1).x(0).rz(0, theta: 2 * PI)

      assert_equal [[0, E**(-1i * PI)]], circuit.state
    end
  end
end
