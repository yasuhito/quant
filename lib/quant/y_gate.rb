# frozen_string_literal: true

require 'quant/gate'

module Quant
  class YGate < Gate
    private

    def matrix
      Matrix[[0, -1i], [1i, 0]]
    end
  end
end
