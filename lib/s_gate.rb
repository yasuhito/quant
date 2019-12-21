# frozen_string_literal: true

require 'gate'

# Phase shift gate S
class SGate < Gate
  private

  def matrix
    Matrix[[1, 0], [0, 1i]]
  end
end
