# frozen_string_literal: true

require 'quant/gate'

module Quant
  class TGate < Gate
    include Symbo

    using Symbo

    private

    def matrix
      Matrix[[1, 0], [0, E**(1i * PI/4)]]
    end
  end
end
