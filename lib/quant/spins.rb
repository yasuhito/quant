# frozen_string_literal: true

module Quant
  include Symbo

  using Symbo

  # 実験装置をθ開店させることに対応する基底は、
  #  [cos(θ/2), -sin(θ/2)],
  #  [sin(θ/2), cos(θ/2)]
  SPINS = {
    '↑' => [Cos[0], -Sin[0]],
    '↓' => [Sin[0], Cos[0]],
    '→' => [Cos[PI/4], -Sin[PI/4]],
    '←' => [Sin[PI/4], Cos[PI/4]],
    '↗' => [Cos[PI/6], -Sin[PI/6]],
    '↙' => [Sin[PI/6], Cos[PI/6]]
  }.freeze
end
