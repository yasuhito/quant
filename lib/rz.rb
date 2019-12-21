# frozen_string_literal: true

require 'gate'

# Z rotation gate
class Rz < Gate
  def initialize(theta)
    @theta = theta
  end

  def matrix
    Matrix[[E**(-1i * @theta / 2), 0],
           [0, E**(-1i * @theta / 2)]]
  end
end
