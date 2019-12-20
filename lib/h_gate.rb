# frozen_string_literal: true

require 'gate'

# Hadamard gate
class HGate < Gate
  private

  def matrix
    Matrix[[1 / sqrt(2), 1 / sqrt(2)], [1 / sqrt(2), -1 / sqrt(2)]]
  end
end
