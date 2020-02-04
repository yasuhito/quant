# frozen_string_literal: true

require 'gate'

# Identity gate
class IdGate < Gate
  using Symbo

  private

  def matrix
    Matrix.I(2)
  end
end
