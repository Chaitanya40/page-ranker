class Page
  attr_reader :key_words

  def initialize(key_words = [])
    @key_words = key_words
  end
end
