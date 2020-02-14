# frozen_string_literal: true

require 'symbo/e'

module Quant
  class R1Gate < Quant::Gate
    include Symbo

    using Symbo

    def initialize(theta)
      @theta = theta
    end

    def matrix
      Matrix[[1, 0],
             [0, E**(1i * @theta)]]
    end
  end
end
