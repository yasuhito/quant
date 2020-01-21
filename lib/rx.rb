# frozen_string_literal: true

require 'gate'
require 'symbolic/division'

# X rotation gate
class Rx < Gate
  def initialize(theta)
    @theta = theta
  end

  def matrix
    Matrix[[Cos(Div(@theta, 2)), -1i * Sin(Div(@theta, 2))],
           [-1i * Sin(Div(@theta, 2)), Cos(Div(@theta, 2))]]
  end
end
