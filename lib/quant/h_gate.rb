# frozen_string_literal: true

require 'quant/gate'

module Quant
  class HGate < Gate
    using Symbo

    private

    def matrix
      Matrix[[1/√(2), 1/√(2)],
             [1/√(2), -1/√(2)]]
    end
  end
end
