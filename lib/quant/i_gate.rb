# frozen_string_literal: true

require 'gate'

module Quant
  class IGate < Gate
    private

    def matrix
      Matrix.I(2)
    end
  end
end
