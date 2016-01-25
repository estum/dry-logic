module Dry
  module Logic
    class Rule::Check < Rule
      attr_reader :keys

      class Unary < Rule::Check
        def evaluate_input(*)
          predicate.input
        end
      end

      class Binary < Rule::Check
        def evaluate_input(result)
          keys.map { |key| result[key].input }
        end
      end

      def initialize(name, predicate, keys)
        super(name, predicate)
        @keys = keys
      end

      def call(result)
        Logic.Result(evaluate_input(result), predicate.(result), self)
      end

      def type
        :check
      end
    end
  end
end
