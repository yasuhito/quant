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
        super(*SPINS.fetch(values[0]))
      else
        raise values[0].inspect
      end
    end
  end
end
