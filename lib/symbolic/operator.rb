# frozen_string_literal: true

require 'symbolic/fraction'
require 'symbolic/refinement/integer'

# Symbolic Algebra
module Symbolic
  using Symbolic::Refinement

  UNDEFINED = :Undefined

  # Symbolic computation operators
  module Operator
    # Returns the order relation of ASAEs
    def compare(u, v)
      # O-1: Suppose that u and v are both constants (integers or fractions).
      #      Then, compare(u, v) → u < v
      return u < v if (u.is_a?(Integer) || u.is_a?(Fraction)) && (v.is_a?(Integer) || v.is_a?(Fraction))

      # O-2: Suppose that u and v are both symbols.
      #      Then, compare(u, v) is defined by the lexicographical order of the symbols.
      return u < v if u.is_a?(Symbol) && v.is_a?(Symbol)

      # O-3: u and v are either both products or both sums.
      if (u.is_a?(Sum) && v.is_a?(Sum)) || (u.is_a?(Product) && v.is_a?(Product))
        return compare(u.operands.last, v.operands.last) if u.operands.last != v.operands.last

        m = u.length
        n = v.length
        if [m, n].min >= 2
          0.upto([m, n].min - 2) do |j|
            return compare(u[m - j - 2], v[n - j - 2]) if u[m - j - 1] == v[n - j - 1] && u[m - j - 2] != v[n - j - 2]
          end
        end

        return compare(m, n)
      end

      # O-4: u and v are both powers.
      if u.is_a?(Power) && v.is_a?(Power)
        return compare(u.base, v.base) if u.base != v.base

        return compare(u.exponent, v.exponent)
      end

      raise 'Not implemented yet'
    end

    def operand(u, i)
      u[i - 1]
    end
  end
end
