# frozen_string_literal: true

require 'gate'

# Identity gate
class IGate < Gate
  using Symbo

  private

  def matrix
    Matrix.I(2)
  end
end
