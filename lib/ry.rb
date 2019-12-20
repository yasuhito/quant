# frozen_string_literal: true

require 'gate'

# Y rotation gate
class Ry < Gate
  def initialize(theta)
    @theta = theta
  end

  def matrix
    Matrix[[cos(@theta / 2), -1 * sin(@theta / 2)],
           [sin(@theta / 2), cos(@theta / 2)]]
  end
end
