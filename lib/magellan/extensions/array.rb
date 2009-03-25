class Array
  def chunk(max_size)
    result = []
    number_of_chunks = (self.size.to_f / max_size).ceil
    for i in 0...number_of_chunks do
      result << self[i*max_size...(i+1)*max_size]
    end
    result
  end
end
