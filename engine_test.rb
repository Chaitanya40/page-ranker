require 'minitest/autorun'
require './engine'

class EngineTest < Minitest::Test
  def test_1
    engine = Engine.new(8, './input2.txt')
    engine.read_input
    engine.run
    assert(FileUtils.identical?('./output2.txt', './output.txt')) == true
  end
end
