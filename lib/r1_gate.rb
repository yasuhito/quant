# frozen_string_literal: true

# R1 rotation gate
class R1Gate < Gate
  def initialize(theta)
    @theta = theta
  end

  private

  def matrix
    Matrix[[1, 0], [0, E**(1i * @theta)]]
  end
end
