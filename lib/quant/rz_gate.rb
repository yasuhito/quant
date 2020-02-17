# frozen_string_literal: true

require 'quant/gate'
require 'symbo'

module Quant
  class RzGate < Gate
    include Symbo

    using Symbo

    def initialize(theta)
      @theta = theta
    end

    def matrix
      Matrix[[E**(-1i*@theta/2), 0],
             [0,                 E**(1i*@theta/2)]]
    end
  end
end
