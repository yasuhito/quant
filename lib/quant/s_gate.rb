# frozen_string_literal: true

require 'quant/gate'

module Quant
  class SGate < Gate
    private

    def matrix
      Matrix[[1, 0], [0, 1i]]
    end
  end
end
