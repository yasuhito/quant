# frozen_string_literal: true

module Quant
  using Symbo

  SPINS = {
    '↑' => [1, 0],
    '↓' => [0, 1],
    '→' => [1/√(2), -1/√(2)],
    '←' => [1/√(2), 1/√(2)],
    '↗' => [1/2, -√(3)/2],
    '↙' => [√(3)/2, 1/2]
  }.freeze
end
