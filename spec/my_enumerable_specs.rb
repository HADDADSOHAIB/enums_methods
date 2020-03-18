require './my_enumerable.rb'

RSpec.describe Enumerable do
  let(:expected_value){ { 'ok' => 'ok', 0 => 0, 1 => 1, 2 => 2, 3 => 3, 1.5 => 1.5, false => false, nil => nil, :a=>:a } }

  describe '#my_each' do
    ['ok', 1, 1.5, false, nil, :a].my_each do |item|
      it "return the same item: #{item} from inside the array" do
        expect(item).to eq(expected_value[item])
      end
    end

    {'ok' => 1, 'ok' => 1, 1.5 => 1, false => 'ok', :a => nil }.my_each do |k, v|
      it "return the same key: #{k} and value: #{v} from inside the hash" do
        expect(v).to eq(expected_value[v])
        expect(k).to eq(expected_value[k])
      end
    end

    (1..3).my_each do |item|
      it "return the same item: #{item} from inside the range" do
        expect(item).to eq(expected_value[item])
      end
    end
  end

  describe '#my_each_with_index' do
    ['ok', 1.5, :a, false].my_each do |item, i|
      it "return the same item: #{item} and the index from inside the array" do
        expect(item).to eq(expected_value[item])
        expect(i).to eq(expected_value[i])
      end
    end

    {'ok' => 1, :a => 0, 1.5 => 1, false => :a }.my_each do |k, v, i|
      it "return the same key: #{k} and value: #{v} and the index from inside the hash" do
        expect(v).to eq(expected_value[v])
        expect(k).to eq(expected_value[k])
        expect(i).to eq(expected_value[i])
      end
    end

    (1..3).my_each do |item, i|
      it "return the same item: #{item} and the index from inside the range" do
        expect(item).to eq(expected_value[item])
        expect(i).to eq(expected_value[i])
      end
    end
  end

  describe "#my_select" do
    it "return only the true values for an array" do
      expect([true, 1, "ok", false, nil].my_select{ |item| item}).to eq([true, 1, "ok"])
    end

    it "return only the true values for a hash" do
      expect({'ok' => 1, :a => 1, 1.5 => nil, false => :a}.my_select{ |k, v| k && v}).to eq({'ok' => 1, :a => 1})
    end

    it "return only the true values for a range" do
      expect((1..10).my_select{ |value| value < 5}).to eq([1, 2, 3, 4])
    end
  end

  describe "#my_all" do
    it "When no block is given, { |item| item } this block is provided" do
      expect([true, 1, "ok", 1.5, :a].my_all?).to eq(true)
    end

    it "When A Parameter is given, { |item| param === item } this block is provided" do
      expect([true, 1, "ok", 1.5, :a].my_all?(String)).to eq(false)
    end

    it "return true only all the values are true for an array" do
      expect([true, 1, "ok", 1.5, :a].my_all?{ |item| item}).to eq(true)
    end

    it "return false only one value is false for an array" do
      expect([true, 1, "ok", 1.5, :a, false].my_all?{ |item| item}).to eq(false)
    end

    it "return true only all the values are true for a hash" do
      expect({'ok' => 1, :a => 1, 1.5 => true}.my_all?{ |k, v| k && v}).to eq(true)
    end

    it "return false only one value is false for a hash" do
      expect({'ok' => 1, :a => 1, 1.5 => nil, false => :a}.my_all?{ |k, v| k && v}).to eq(false)
    end

    it "return true only all the values are true for a range" do
      expect((1..10).my_all?{ |value| value <= 10}).to eq(true)
    end

    it "return false only one value is false for a range" do
      expect((1..10).my_all?{ |value| value <= 9}).to eq(false)
    end
  end

  describe "#my_any" do
    it "When no block is given, { |item| item } this block is provided" do
      expect(["ok", false, nil].my_any?).to eq(true)
    end

    it "When A Parameter is given, { |item| param === item } this block is provided" do
      expect([true, 1, "ok", 1.5, :a].my_any? String ).to eq(true)
    end

    it "return true only one value is true for an array" do
      expect([true, false, nil, 1].my_any?{ |item| item}).to eq(true)
    end

    it "return false only when all values are false for an array" do
      expect([false, false, nil, nil, false].my_any?{ |item| item}).to eq(false)
    end

    it "return true only one value is true for a hash" do
      expect({'ok' => 1, :a => 1, 1.5 => true}.my_any?{ |k, v| k && v}).to eq(true)
    end

    it "return false only when all values are false for a hash" do
      expect({'ok' => false, :a => false, 1.5 => nil, false => :a}.my_any?{ |k, v| k && v}).to eq(false)
    end

    it "return true only one value is true for a range" do
      expect((1..10).my_any?{ |value| value <= 1}).to eq(true)
    end

    it "return false only when all values are false for a range" do
      expect((1..10).my_any?{ |value| value <= 0}).to eq(false)
    end
  end

  describe "#my_none?" do
    it "When no block is given, return true is none of the element is true" do
      expect([false, nil].my_none?).to eq(true)
    end

    it "When no block is given, return false an element is true" do
      expect([true, false, nil].my_none?).to eq(false)
    end

    it "When A Parameter is given, { |item| param === item } this block is provided" do
      expect([true, 1, "ok", 1.5, :a].my_none? String ).to eq(false)
    end

    it "When A Parameter is given, { |item| param === item } this block is provided" do
      expect([true, 1, 1.5, :a].my_none? String ).to eq(true)
    end

    it "return false only if one value is true for an array" do
      expect([true, false, nil, 1].my_none?{ |item| item}).to eq(false)
    end

    it "return true only when all values are false for an array" do
      expect([false, false, nil, nil, false].my_none?{ |item| item}).to eq(true)
    end

    it "return false only if one value is true for a hash" do
      expect({'ok' => nil, :a => false, 1.5 => true}.my_none?{ |k, v| k && v}).to eq(false)
    end

    it "return true only when all values are false for a hash" do
      expect({'ok' => false, :a => false, 1.5 => nil, false => :a}.my_none?{ |k, v| k && v}).to eq(true)
    end

    it "return false only if one value is true for a range" do
      expect((1..10).my_none?{ |value| value <= 1}).to eq(false)
    end

    it "return true only when all values are false for a range" do
      expect((1..10).my_none?{ |value| value <= 0}).to eq(true)
    end
  end

  describe "#my_count" do
    it "Return the size of the element when no block nor parametre is provided" do
      expect([false, nil, 2, "ok", true, :a].my_count).to eq(6)
    end

    it "when a parametre is passed, it returns the count of the element equal to the param" do
      expect([false, 2, 2, "ok", 2, :a].my_count(2)).to eq(3)
    end

    it "Return the size of the element when no block nor parametre is provided" do
      expect([false, nil, 2, "ok", true, :a].my_count).to eq(6)
    end
    
    it "return the number of element that meet the condition in the block for an array" do
      expect([1, true, 1, false, nil, 1].my_count{ |item| item == 1}).to eq(3)
    end

    it "return the number of element that meet the condition in the block for a hash" do
      expect({ :b => 'ok', :a => 'ok', 'ok' => true}.my_count{ |k, v| k == 'ok' || v == 'ok'}).to eq(3)
    end

    it "return the number of element that meet the condition in the block for a range" do
      expect((1..10).my_count{ |value| value <= 4}).to eq(4)
    end
  end

  describe '#my_map' do
    it "return the item * 3 from inside the array" do
      new_array = [0, 1, 2, 3].my_map{ |item| item * 3 }
      expect(new_array).to eq([0, 3, 6, 9])
    end

    it "return the result from inside the hash" do
      result = {1 => 2, 3 => 4, 0 => 1}.my_map{ |k, v| k * v }
      expect(result).to eq([2, 12, 0])
    end

    it "return the result from inside a range" do
      result = (1..5).my_map{ |item| item * 3 }
      expect(result).to eq([ 3, 6, 9, 12, 15])
    end
  end

  describe '#my_map_with_proc' do
    let(:proc){ Proc.new { |item| item * 3 } }
    let(:proc_hash){ Proc.new { |k, v| k * v } }
    it "return the item * 3 from inside the array" do
      new_array = [0, 1, 2, 3].my_map_with_proc(&proc)
      expect(new_array).to eq([0, 3, 6, 9])
    end

    it "return the result from inside the hash" do
      result = {1 => 2, 3 => 4, 0 => 1}.my_map_with_proc(&proc_hash)
      expect(result).to eq([2, 12, 0])
    end

    it "return the result from inside a range" do
      result = (1..5).my_map_with_proc(&proc)
      expect(result).to eq([ 3, 6, 9, 12, 15])
    end
  end

  describe '#my_map_with_proc_or_block' do
    let(:proc){ Proc.new { |item| item * 3 } }
    let(:proc_hash){ Proc.new { |k, v| k * v } }
    it "return the item * 3 from inside the array" do
      new_array = [0, 1, 2, 3].my_map_with_proc_or_block(&proc)
      expect(new_array).to eq([0, 3, 6, 9])
    end

    it "return the item * 3 from inside the array" do
      new_array = [0, 1, 2, 3].my_map_with_proc_or_block { |item| item * 3 }
      expect(new_array).to eq([0, 3, 6, 9])
    end

    it "return the result from inside the hash" do
      result = {1 => 2, 3 => 4, 0 => 1}.my_map_with_proc_or_block(&proc_hash)
      expect(result).to eq([2, 12, 0])
    end

    it "return the result from inside the hash" do
      result = {1 => 2, 3 => 4, 0 => 1}.my_map_with_proc_or_block { |k, v| k * v }
      expect(result).to eq([2, 12, 0])
    end

    it "return the result from inside a range" do
      result = (1..5).my_map_with_proc_or_block(&proc)
      expect(result).to eq([ 3, 6, 9, 12, 15])
    end

    it "return the result from inside a range" do
      result = (1..5).my_map_with_proc_or_block { |item| item * 3 }
      expect(result).to eq([ 3, 6, 9, 12, 15])
    end
  end

  describe '#my_inject' do
    it "return the sum of all values plus the param" do
      expect([0, 1, 2, 3].inject(5){ |sum, v| sum + v }).to eq(11)
    end

    it "return the sum of all values when no initial value is provided" do
      expect([0, 1, 2, 3].inject{ |sum, v| sum + v }).to eq(6)
    end

    it "return the result of the applied operation on all values" do
      expect([1, 2, 3, 4].inject(:*)).to eq(24)
    end
  end
end