# frozen_string_literal: true

require 'symbolic/pi'
require 'symbolic/sqrt'

module Symbolic
  # 三角関数のシンボリック演算
  class TrigonometricFunction
    def initialize(theta)
      @theta = theta
    end

    def simplify
      self.class.const_get(:TABLE).fetch @theta
    end
  end
end
