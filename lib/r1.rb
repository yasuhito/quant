# frozen_string_literal: true

require 'symbolic/e'

# R1 rotation gate
class R1 < Gate
  def initialize(theta)
    @theta = theta
  end

  def matrix
    Matrix[[1, 0],
           [0, Symbolic::E**(1i * @theta)]]
  end
end
