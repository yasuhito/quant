# frozen_string_literal: true

require 'symbo/e'

# R1 rotation gate
class R1 < Quant::Gate
  def initialize(theta)
    @theta = theta
  end

  def matrix
    Matrix[[1, 0],
           [0, Symbo::E**(1i * @theta)]]
  end
end
