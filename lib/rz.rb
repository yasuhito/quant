# frozen_string_literal: true

require 'gate'
require 'symbo/e'

# Z rotation gate
class Rz < Gate
  def initialize(theta)
    @theta = theta
  end

  def matrix
    Matrix[[Symbo::E**(-1i * @theta / 2), 0],
           [0, Symbo::E**(-1i * @theta / 2)]]
  end
end
