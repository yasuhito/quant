# frozen_string_literal: true

require 'symbolic/base'
require 'symbolic/integer'
require 'symbolic/pi'
require 'symbolic/sqrt'

module Symbolic
  # シンボリックな積
  class Product < Base
    def initialize(*terms)
      @terms = terms
    end

    def *(other)
      Product.new(@terms + [other])
    end

    def /(other)
      Rational.new(self, other)
    end

    def zero?
      @terms.map(&:simplify).any?(&:zero?)
    end

    def simplify
      return nil if @terms.empty?
      return 0 if @terms.any?(&:zero?)
      return @terms.first if @terms.size == 1

      if @terms.all? { |each| each.is_a?(Sqrt) }
        rest = @terms[1..-1]
        index = rest.find_index(@terms.first)

        if index
          rest.delete_at(index)
          if rest.empty?
            return @terms.first.value
          else
            return @terms.first.value * Product.new(*rest).simplify
          end
        else
          return @terms.first * Product.new(*rest).simplify
        end
      end

      return @terms.inject(:*) if @terms.all? { |each| each.is_a?(Numeric) }
      return @terms.inject(:*) if @terms.all? { |each| each.is_a?(Rational) }
      return self if @terms.all? { |each| each.is_a?(Base) }

      result = Product.new(*[numeric_terms.inject(:*),
                             Product.new(*sqrt_terms).simplify,
                             Product.new(*rational_terms).simplify,
                             Product.new(*pi_terms).simplify].compact)

      if numeric_terms.length <= 1 &&
         sqrt_terms.length <= 1 &&
         rational_terms.length <= 1 &&
         pi_terms.length <= 1
        result
      else
        result.simplify
      end
    end

    def ==(other)
      return false unless other.simplify.is_a?(Product)

      (numeric_terms == other.numeric_terms) &&
        (sqrt_terms == other.sqrt_terms) &&
        (rational_terms == other.rational_terms) &&
        (pi_terms == other.pi_terms)
    end

    def to_s
      "#{numeric_terms.join('*')}#{sqrt_terms.join('*')}"
    end

    def numeric_terms
      # terms_simplified.select { |each| each.is_a?(Numeric) }
      @terms.select { |each| each.is_a?(Numeric) }
    end

    def sqrt_terms
      # terms_simplified.select { |each| each.is_a?(Sqrt) }
      @terms.select { |each| each.is_a?(Sqrt) }
    end

    def rational_terms
      # terms_simplified.select { |each| each.is_a?(Rational) }
      @terms.select { |each| each.is_a?(Rational) }
    end

    def pi_terms
      @terms.select { |each| each.is_a?(Pi) }
    end

    def eql?(other)
      self.==(other)
    end

    def hash
      @terms.hash
    end

    private

    def terms_simplified
      @terms.dup.map { |each| each.is_a?(Base) ? each.simplify : each }
    end
  end
end
