# frozen_string_literal: true

require 'gate'

# Pauli-Z gate
class ZGate < Gate
  private

  def matrix
    Matrix[[1, 0], [0, -1]]
  end
end
