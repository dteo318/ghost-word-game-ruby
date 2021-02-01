class Dictionary
  def initialize(file_path)
    @dictionary = self.load_dictionary(file_path)
  end

  def load_dictionary(file_path)
    dict_arr = IO.readlines(file_path)
    dict_arr.map(&:chomp)
  end

  def include?(word)
    dict_set = @dictionary.to_set
    dict_set.include?(word)
  end

  def words_start_with?(fragment)
    @dictionary.any? { |word| word.start_with?(fragment) }
  end
end
