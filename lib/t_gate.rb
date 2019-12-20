# frozen_string_literal: true

require 'gate'

# Phase shift gate T
class TGate < Gate
  private

  def matrix
    Matrix[[1, 0], [0, E**(1i * PI / 4)]]
  end
end
