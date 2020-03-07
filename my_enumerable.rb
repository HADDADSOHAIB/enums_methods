# rubocop:disable Style/CaseEquality, Metrics/ModuleLength, Style/For, Lint/RedundantCopDisableDirective
module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    for element in self
      yield(element)
    end
  end
end

# rubocop:enable Style/CaseEquality, Metrics/ModuleLength, Style/For, Lint/RedundantCopDisableDirective
