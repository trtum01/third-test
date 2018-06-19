require 'helpers'

describe PQ do
  let(:queue) { PQ.new }

  describe '#empty? and #any?' do
    specify do
      expect(queue.empty?).to eq(!queue.any?).and eq(true)
      queue.add *(1..2).map { rand 100_500 }
      expect(queue.empty?).to eq(!queue.any?).and eq(false)
    end
  end

  describe '#size' do
    specify do
      expect(queue.size).to eq(0)
      queue.add *(1..2).map { rand 100_500 }
      expect(queue.size).to eq(2)
    end
  end

  describe '#count' do
    specify do
      expect(queue.method(:count)).to eq(queue.method(:size))
    end
  end

  describe '#add' do
    specify do
      expect { queue.add 10, 20, 30, -40 }.to_not raise_error
      expect(queue.to_a).to eq([30, 20, 10, -40])
    end
  end

  describe '#<<' do
    specify do
      expect(queue.method(:<<)).to eq(queue.method(:add))
    end
  end

  describe '#pop' do
    specify do
      expect(queue.pop).to eq(nil)
      expect { queue.add 10, 20, 30, -40 }.to_not raise_error
      expect(queue.pop).to eq(30)
      expect(queue.pop).to eq(20)
      expect(queue.pop).to eq(10)
      expect(queue.pop).to eq(-40)
      expect(queue.pop).to eq(nil)
    end
  end

  describe 'include Enumerable' do
    specify do
      expect(queue.methods).to include(*Enumerable.instance_methods)
    end
  end

  describe 'comparator' do
    specify 'default' do
      q = PQ.new
      q.add *(1..3)
      expect(q.to_a).to eq([3, 2, 1])
    end

    specify 'a' do
      q = PQ.new { |a| a }
      q.add *(1..3)
      expect(q.to_a).to eq([3, 2, 1])
    end

    specify 'b' do
      q = PQ.new(&:-@)
      q.add *(1..3)
      expect(q.to_a).to eq([1, 2, 3])
    end

    specify 'b' do
      q = PQ.new { |a| a.even? ? a : -a }
      q.add *(1..3)
      expect(q.to_a).to eq([2, 1, 3])
    end
  end
end
