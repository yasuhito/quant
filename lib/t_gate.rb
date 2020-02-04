# frozen_string_literal: true

require 'gate'
require 'symbo/e'
require 'symbo/pi'

# Phase shift gate T
class TGate < Gate
  private

  def matrix
    Matrix[[1, 0], [0, Symbo::E**(1i * Symbo::PI / 4)]]
  end
end
