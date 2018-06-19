# PQ [![Build Status](https://travis-ci.org/zinenko/pq.svg?branch=master)](https://travis-ci.org/zinenko/pq)

Priority queue implementation [wiki](https://en.wikipedia.org/wiki/Priority_queue#Specialized_heaps)

## Install:

```
gem install pq
```

## How to use:

```.ruby
queue = PQ.new

queue << 0
queue << 1
queue << -1
queue << +100500

queue.each do |i|
  puts i
end

# => 100500
# => 1
# => 0
# => -1
```

## Performance

```.ruby
require 'pq'
require 'benchmark/ips'

class NaiveQueue
  def initialize
    @elements = []
  end

  def <<(element)
    @elements << element
  end

  def pop
    last_element_index = @elements.size - 1
    @elements.sort!
    @elements.delete_at(last_element_index)
  end
end

naive_queue = NaiveQueue.new
priority_queue = PQ.new

100_000.times do |i|
  naive_queue << i
  priority_queue  << i
end

Benchmark.ips do |x|
  x.report("naive") { naive_queue.pop }
  x.report("pq")    { priority_queue.pop  }

  x.compare!
end
```

## Result

```
Warming up --------------------------------------
               naive   178.000  i/100ms
                  pq    20.738k i/100ms
Calculating -------------------------------------
               naive      1.888k (± 6.1%) i/s -      9.434k in   5.016797s
                  pq      1.243M (± 9.9%) i/s -      6.138M in   5.001097s

Comparison:
                  pq:  1242931.0 i/s
               naive:     1888.0 i/s - 658.33x  slower
```