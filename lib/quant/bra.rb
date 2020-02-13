# frozen_string_literal: true

require 'quant/row_vector'
require 'quant/spins'

module Quant
  class Bra < RowVector
    def self.[](*values)
      case values[0]
      when Integer, Symbo::Expression
        super(*values)
      when String
        raise "Unknown values: #{values.inspect}" if values.size > 1

        super(*SPINS.fetch(values[0]))
      else
        raise "Unknown values: #{values.inspect}"
      end
    end

    def to_ary
      to_a
    end
  end
end
