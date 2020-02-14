# frozen_string_literal: true

require 'quant/gate'

module Quant
  class ZGate < Gate
    private

    def matrix
      Matrix[[1, 0], [0, -1]]
    end
  end
end
