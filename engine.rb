require './page'
require './query'
require './weightage_calculator'

class Engine
  def initialize(max_query_length = 8, input_file_path)
    @max_query_length = max_query_length
    @input_file_path = input_file_path
    @pages = []
    @queries = []
    @result = {}
  end

  def read_input
    File.foreach(@input_file_path) do |line|
      if line.start_with?('P')
        @pages << line.split(' ').drop(1)
      elsif line.start_with?('Q')
        @queries << line.split(' ').drop(1)
      end
    end
  end

  def run
    @queries.each_with_index do |query_words, query_number|
      @pages.each_with_index do |page_words, page_number|
        page = Page.new(page_words.map(&:downcase))
        query = Query.new(query_words.map(&:downcase))
        weightage = WeightageCalculator.new(page, query, @max_query_length).run
        if @result[query_number].nil?
          @result[query_number] = [{ page_number: page_number, weightage: weightage }]
        else
          @result[query_number] << { page_number: page_number, weightage: weightage }
        end
      end
      @result[query_number].select! { |a| a[:weightage] != 0 }
    end

    # pp @result

    File.open('./output.txt', 'w') do |file|
      @result.each do |query_key, weightages|
        weightages.sort! { |x, y| y[:weightage] <=> x[:weightage] }.first(5)
        file.write "Q#{query_key + 1}: #{weightages.first(5).map { |a| "P#{a[:page_number] + 1}" }.join(' ')}\n"
      end
    end
  end
end
