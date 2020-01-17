# frozen_string_literal: true

require 'gate'

# Hadamard gate
class H < Gate
  using Symbolic

  private

  def matrix
    Matrix[[1 / Sqrt(2), 1 / Sqrt(2)],
           [1 / Sqrt(2), -1 / Sqrt(2)]]
  end
end
