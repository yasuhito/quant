# frozen_string_literal: true

require 'gate'

# Pauli-Y gate
class YGate < Gate
  private

  def matrix
    Matrix[[0, -1i], [1i, 0]]
  end
end
