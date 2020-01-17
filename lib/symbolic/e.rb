# frozen_string_literal: true

require 'symbolic/base'
require 'symbolic/pow'

module Symbolic
  # シンボリックなネイピア数
  class Napier < Base
    def **(other)
      Pow.new(self, other)
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
