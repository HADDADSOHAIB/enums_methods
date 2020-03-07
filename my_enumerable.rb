# rubocop:disable Style/CaseEquality, Metrics/ModuleLength, Style/For, Lint/RedundantCopDisableDirective
module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    for element in self
      yield(element)
    end
  end

  def my_each_with_index
    i = 0
    return to_enum(:my_each_with_index) unless block_given?

    for element in self
      yield(element, i)
      i += 1
    end
  end
end

# rubocop:enable Style/CaseEquality, Metrics/ModuleLength, Style/For, Lint/RedundantCopDisableDirective
