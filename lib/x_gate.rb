# frozen_string_literal: true

require 'gate'

# Pauli-X gate
class XGate < Gate
  private

  def matrix
    Matrix[[0, 1], [1, 0]]
  end
end
