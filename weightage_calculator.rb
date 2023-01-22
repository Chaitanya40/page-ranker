class WeightageCalculator
  def initialize(page, query, max_query_length)
    @max_query_length = max_query_length
    @page = page
    @query = query
  end

  def run
    weightage = 0
    @query.key_words.each_with_index do |word, index|
      page_word_index = @page.key_words.index(word)
      weightage += (page_word_index.nil? ? 0 : (@max_query_length - page_word_index) * (@max_query_length - index))
    end
    weightage
  end
end
