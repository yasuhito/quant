# frozen_string_literal: true

require 'gate'

# Z rotation gate
class RzGate < Gate
  def initialize(theta)
    @theta = theta
  end

  private

  def matrix
    Matrix[[E**(-1i * @theta / 2), 0],
           [0, E**(-1i * @theta / 2)]]
  end
end
