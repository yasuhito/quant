# frozen_string_literal: true

require 'quant/gate'
require 'symbo/division'

# X rotation gate
class Rx < Quant::Gate
  def initialize(theta)
    @theta = theta
  end

  def matrix
    Matrix[[Cos(Div(@theta, 2)), -1i * Sin(Div(@theta, 2))],
           [-1i * Sin(Div(@theta, 2)), Cos(Div(@theta, 2))]]
  end
end
