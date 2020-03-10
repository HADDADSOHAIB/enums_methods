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
  end
end