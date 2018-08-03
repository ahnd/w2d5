class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
    @num_buckets = num_buckets
  end

  def insert(key)
    unless self.include?(key)
      if @count >= @num_buckets
        resize!
      end
        self[key] << key
        @count += 1
    end
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    if self.include?(key)
      self[key].delete(key)
      @count -= 1
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
   a = @store.flatten
    @count = 0
    @store = Array.new(num_buckets * 2) { Array.new }

  a.each { |num| insert(num) }
  end
end
