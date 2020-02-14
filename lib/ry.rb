# frozen_string_literal: true

require 'quant/gate'

# Y rotation gate
class Ry < Quant::Gate
  def initialize(theta)
    @theta = theta
  end

  def matrix
    Matrix[[cos(@theta / 2), -1 * sin(@theta / 2)],
           [sin(@theta / 2), cos(@theta / 2)]]
  end
end
