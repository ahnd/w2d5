class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    each_with_index.inject(0) do |subhash, (el,i)|
      (el.hash + i.hash) ^ subhash
    end
  end
end

class String
  def hash
    chars.map{|letter| letter.ord}.hash

  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    to_a.sort_by(&:hash).hash
  end
end
