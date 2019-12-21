# frozen_string_literal: true

# R1 rotation gate
class R1 < Gate
  def initialize(theta)
    @theta = theta
  end

  def matrix
    Matrix[[1, 0],
           [0, E**(1i * @theta)]]
  end
end
