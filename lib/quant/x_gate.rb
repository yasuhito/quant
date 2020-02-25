# frozen_string_literal: true

require 'quant/gate'

module Quant
  class XGate < Gate
    def matrix
      Matrix[[0, 1], [1, 0]]
    end
  end
end
