# frozen_string_literal: true

require 'gate'

# X rotation gate
class RxGate < Gate
  def initialize(theta)
    @theta = theta
  end

  private

  def matrix
    Matrix[[cos(@theta / 2), -1i * sin(@theta / 2)],
           [-1i * sin(@theta / 2), cos(@theta / 2)]]
  end
end
