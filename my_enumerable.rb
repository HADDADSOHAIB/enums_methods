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

  def my_select
    return to_enum(:my_select) unless block_given?

    new_self = []
    new_self = {} if is_a? Hash

    my_each do |element|
      if new_self.is_a? Hash
        next unless yield(element[0], element[1])

        new_self[element[0]] = element[1]
      else
        next unless yield(element)

        new_self << element
      end
    end

    new_self
  end

  def my_all?(param = nil)
    if !block_given?
      my_all? { |element| param.nil? ? element : param === element }
    elsif is_a? Hash
      count = 0
      my_each do |element|
        break unless yield(element[0], element[1])

        count += 1
      end
      count == size
    else
      count = 0
      my_each do |element|
        break unless yield(element)

        count += 1
      end
      count == size
    end
  end

  def my_any?(param = nil)
    if !block_given?
      my_any? { |element| param.nil? ? element : param === element }
    elsif is_a? Hash
      my_each do |element|
        return true if yield(element[0], element[1])
      end
      false
    else
      my_each do |element|
        return true if yield(element)
      end
      false
    end
  end

  def my_none?(param = nil)
    if !block_given?
      my_none? { |element| param.nil? ? element : param === element }
    elsif is_a? Hash
      count = 0
      my_each do |element|
        break if yield(element[0], element[1]) == true

        count += 1
      end
      count == size
    else
      count = 0
      my_each do |element|
        break if yield(element) == true

        count += 1
      end
      count == size
    end
  end

  def my_count(param = nil)
    count = 0
    return param.nil? ? size : my_count { |element| param == element } unless block_given?

    if is_a? Hash
      my_each do |element|
        next unless yield(element[0], element[1])

        count += 1
      end
    else
      my_each do |element|
        next unless yield(element)

        count += 1
      end
    end
    count
  end

  def my_map
    return to_enum(:my_map) unless block_given?

    new_self = []
    my_each do |element|
      new_self << if is_a? Hash
                    yield(element[0], element[1])
                  else
                    yield(element)
                  end
    end

    new_self
  end

  def my_map_with_proc(&proc)
    return to_enum(:my_map_with_proc) unless block_given?

    new_self = []
    my_each do |element|
      new_self << if is_a? Hash
                    proc.call(element[0], element[1])
                  else
                    proc.call(element)
                  end
    end

    new_self
  end

  def my_map_with_proc_or_block(&proc)
    return to_enum(:my_map_with_proc_or_block) unless block_given? 

    new_self = []
    my_each do |element|
      new_self << if is_a? Hash
                    (proc ? proc.call(element[0], element[1]) : yield(element[0], element[1]))
                  else
                    (proc ? proc.call(element) : yield(element))
                  end
    end

    new_self
  end
end
# rubocop:enable Style/CaseEquality, Metrics/ModuleLength, Style/For, Lint/RedundantCopDisableDirective
