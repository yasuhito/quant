# frozen_string_literal: true

module Symbo
  module Mergeable
    private

    # rubocop:disable Metrics/PerceivedComplexity
    # rubocop:disable Metrics/CyclomaticComplexity
    def merge(p, q) # rubocop:disable Naming/MethodParameterName
      if q.empty?
        p
      elsif p.empty?
        q
      else
        p1 = p[0]
        q1 = q[0]
        h = simplify_rec([p1, q1])
        case h
        in []
          merge p[1..-1], q[1..-1]
        in [_]
          h + merge(p[1..-1], q[1..-1])
        in ^p1, ^q1
          [p1] + merge(p[1..-1], q)
        in ^q1, ^p1
          [q1] + merge(p, q[1..-1])
        end
      end
    end
    # rubocop:enable Metrics/PerceivedComplexity
    # rubocop:enable Metrics/CyclomaticComplexity
  end
end
