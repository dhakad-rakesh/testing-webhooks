# This class has extra methods added to string class
class String
  def xml_to_hash
    Hash.from_xml(self).with_indifferent_access
  end
end

class Hash
  # If we have existing key then those values will be added / sum
  # Merge 2 hash
  def union_with_sum(hash_b)
    merge(hash_b) { |_k, a_value, b_value| a_value + b_value }
  end

  def union_with_average(hash_b)
    merge(hash_b) { |_k, a_value, b_value| ((a_value + b_value) / 2).round(2) }
  end
end
