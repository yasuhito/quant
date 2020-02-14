# frozen_string_literal: true

require 'quant/gate'

module Quant
  class RyGate < Gate
    def initialize(theta)
      @theta = theta
    end

    def matrix
      Matrix[[Cos(@theta/2), -1 * Sin(@theta/2)],
             [Sin(@theta/2), Cos(@theta/2)]]
    end
  end
end
