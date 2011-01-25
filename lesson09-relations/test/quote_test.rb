require "test/unit"

require File.dirname(__FILE__) + "/../lib/database"
require File.dirname(__FILE__) + "/../lib/quote"
require File.dirname(__FILE__) + "/../config/test"

class QuoteTest < Test::Unit::TestCase
  
  def test_connection
    assert connection
    assert_equal "quotes_test", db_select_one_value("select database()")
  end
  
end

