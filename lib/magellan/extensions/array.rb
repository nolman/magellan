class Array
  # Break down an array into chunks of a given max size.
  # Example:
  #  [1,2,3,4].chunk(3)    # => [[1,2,3],[4]]
  #  [1,2,3,4].chunk(2)    # => [[1,2],[3,4]]
  def chunk(max_size)
    result = []
    number_of_chunks = (self.size.to_f / max_size).ceil
    for i in 0...number_of_chunks do
      result << self[i*max_size...(i+1)*max_size]
    end
    result
  end
end
