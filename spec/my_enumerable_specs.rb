require './my_enumerable.rb'

RSpec.describe Enumerable do
  let(:expected_value){ { 'ok' => 'ok', 1 => 1, 2 => 2, 3 => 3, 1.5 => 1.5, false => false, nil => nil, :a=>:a } }

  describe '#my-each' do
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
end