class MaxIntSet #O(1) but space complexity would increase dpeneding on max
  def initialize(max)
    @store = Array.new(max, false)
    @max = max
  end

  def insert(num)
    raise "Out of bounds" if is_valid?(num)
    @store[num] = true
  end

  def remove(num)
    raise Error if is_valid?(num)
    @store[num] = false
  end

  def include?(num)
    raise Error if is_valid?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    (num > @max || num < 0) && @max.is_a?(Integer)
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @num_buckets = num_buckets
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % @num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
    @num_buckets = num_buckets
  end

  def insert(num)
    unless self.include?(num)
      if @count >= @num_buckets
        resize!
      end
        self[num] << num
        @count += 1

    end
  end

  def remove(num)
    if self.include?(num)
      self[num].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % @num_buckets]
  end

  def resize!
    a = @store.flatten
    a.each do |num|
      self.remove(num)
    end

    @num_buckets.times do
      @store << []
    end

    @num_buckets = 2 * @num_buckets

    a.each do |num|
      self.insert(num)
    end

    #a.each {|num| insert(num)}
  end

  def num_buckets
    @store.length
  end

end
