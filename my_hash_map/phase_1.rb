class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
    @max = max
  end

  def in_bound?(num)
     (num > @max || num < 0) && @max.is_a?(Integer)
  end

  def insert(num)
    raise Error if in_bound?(num)
    @store[num] = true
  end

  def remove(num)
    raise Error if in_bound?(num)
    @store[num] = false
  end

  def include?(num)
    raise Error if in_bound?(num)
    @store[num]
  end
end

class MaxIntSet
  def initialize(max = 20)
    @cache = Array.new(max){[]}
    @max = max
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
    @cache[num % @max]
  end
end

class ResizingInt
  def initialize(max = 9)
    @cache = Array.new(max){[]}
    @max = max
    @count = 0
  end

  def insert(num)
    unless self.include?(num)
      if @count >= @max
        add_buckets
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

  def add_buckets
    10.times do
      @cache << []
    end
    @max += 10
  end

  private
  def [](num)
    @cache[num % @max]
  end
end
