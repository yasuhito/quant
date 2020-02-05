# frozen_string_literal: true

module Symbo
  refine Complex do
    def simplify
      dup
    end
  end
end
