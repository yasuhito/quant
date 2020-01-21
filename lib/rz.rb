# frozen_string_literal: true

require 'gate'
require 'symbolic/e'

# Z rotation gate
class Rz < Gate
  def initialize(theta)
    @theta = theta
  end

  def matrix
    Matrix[[Symbolic::E**(-1i * @theta / 2), 0],
           [0, Symbolic::E**(-1i * @theta / 2)]]
  end
end
