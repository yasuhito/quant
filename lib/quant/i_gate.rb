# frozen_string_literal: true

require 'quant/gate'

module Quant
  class IGate < Gate
    def matrix
      Matrix.I(2)
    end
  end
end
