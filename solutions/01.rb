class Integer

  def prime?
    return false if self <= 0
    self.is_not_divisible_by? 2
  end

  def is_not_divisible_by?(divisor)
    return true if divisor > Math.sqrt(self)
    return false if self % divisor == 0
    self.is_not_divisible_by? divisor + 1
  end

  def prime_factors
    new_self = self > 0 ? self : -self
    make_divisors_array 2, [], new_self
  end

  def make_divisors_array(divisor, result_array, new_self)
    while new_self > 1
      while new_self % divisor == 0
        result_array << divisor
        new_self = new_self / divisor
      end
      divisor = divisor + 1
    end
    return result_array
  end

  def harmonic
    (1..self).to_a.map { |n| Rational(1, n) }.inject { |sum, n| sum + n }
  end

  def digits
    new_self = self
    digits_array = []
    while new_self > 0
      digits_array << new_self % 10
      new_self /= 10
    end
    return digits_array.reverse
  end

end

class Array

  def frequencies
    frequencies_hash = {}
    self.each { |element| frequencies_hash[element] = self.count element }
    return frequencies_hash
  end

  def average
    new_self = self
    return Rational(new_self.inject { |sum, n| sum + n}, new_self.count).to_f
  end

  def drop_every(n)
    result_array = []
    self.each_index { |i| result_array << self[i] if (i + 1) % n != 0 }
    return result_array
  end

  def combine_with(other)
    return self if other == []
    return other if self == []
    return self.make_combination other, []
  end

  def make_combination(other, result_array)
    result_array << self.shift << other.shift
    return result_array += self if other == []
    return result_array += other if self == []
    return self.make_combination other, result_array
  end

end