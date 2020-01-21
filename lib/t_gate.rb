# frozen_string_literal: true

require 'gate'
require 'symbolic/e'
require 'symbolic/pi'

# Phase shift gate T
class TGate < Gate
  private

  def matrix
    Matrix[[1, 0], [0, Symbolic::E**(1i * Symbolic::PI / 4)]]
  end
end
