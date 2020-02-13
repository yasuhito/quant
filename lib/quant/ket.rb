# frozen_string_literal: true

require 'quant/column_vector'
require 'quant/spins'

module Quant
  class Ket < ColumnVector
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
