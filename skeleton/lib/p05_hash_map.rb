require_relative 'p04_linked_list'
require 'byebug'

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store.any?{|list| list.include?(key)}
  end

  def set(key, val)
    resize! if @count >= num_buckets
    if include?(key)
      @store[key.hash % num_buckets].update(key, val)
    else
      @store[key.hash % num_buckets].append(key, val)
      @count += 1
    end
  end

  def get(key)
    @store.each do |list|
      return list.get(key) if list.include?(key)
    end
    nil
  end

  def delete(key)
    @store.map do |list|
      if list.include?(key)
        list.remove(key)
        @count -= 1
      end
    end
  end

  def each(&prc)
    result = []
    @store.each do |list|
      list.each do |node|

        prc.call(node.key, node.val)
      end
    end
    result

  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    a = @store
    @store = Array.new(num_buckets * 2) { LinkedList.new }
    @count = 0

    a.each do |list|
      list.each {|node| set(node.key, node.val)}
    end
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
