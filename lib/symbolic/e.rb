# frozen_string_literal: true

require 'symbolic/base'
require 'symbolic/power'

module Symbolic
  # シンボリックなネイピア数
  class Napier < Base
    def **(other)
      Pow(self, other)
    end

    def simplify
      dup
    end

    def inspect
      'e'
    end
  end

  E = Napier.new
end
