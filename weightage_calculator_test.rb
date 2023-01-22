require 'minitest/autorun'
require './page'
require './query'
require './weightage_calculator'

class WeightageCalculatorTest < Minitest::Test
  def test_1
    page = Page.new(%w[ford car review])
    query = Query.new(%w[ford car])
    weightage_calculator = WeightageCalculator.new(page, query, 8)
    assert weightage_calculator.run == 113
  end

  def test_2
    page = Page.new(%w[toyota car])
    query = Query.new(%w[ford car])
    weightage_calculator = WeightageCalculator.new(page, query, 8)
    assert weightage_calculator.run == 49
  end

  def test_3
    page = Page.new(%w[car ford])
    query = Query.new(%w[ford car])
    weightage_calculator = WeightageCalculator.new(page, query, 8)
    assert weightage_calculator.run == 112
  end

  def test_4
    page = Page.new(%w[ford car review])
    query = Query.new(%w[ford review])
    weightage_calculator = WeightageCalculator.new(page, query, 8)
    assert weightage_calculator.run == 106
  end

  def test_5
    page = Page.new(%w[toyota car])
    query = Query.new(%w[ford review])
    weightage_calculator = WeightageCalculator.new(page, query, 8)
    assert weightage_calculator.run == 0
  end

  def test_6
    page = Page.new(%w[car ford])
    query = Query.new(%w[ford review])
    weightage_calculator = WeightageCalculator.new(page, query, 8)
    assert weightage_calculator.run == 56
  end
end
