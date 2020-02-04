# frozen_string_literal: true

# 複素数のシンボリック演算
class Complex
  alias original_multiply *
  alias original_division /

  def *(other)
    if other.is_a?(Symbo::Base)
      Symbo::Product.new(self, other)
    else
      original_multiply other
    end
  end

  def /(other)
    Symbo::Rational.new(self, other)
  end

  def simplify
    dup
  end

  # def inspect
  #   if real.zero?
  #     if imag == 1
  #       'i'
  #     elsif imag == -1
  #       '-i'
  #     else
  #       "#{imag}i"
  #     end
  #   else
  #     "#{real}+#{imag}i"
  #   end
  # end
end
