require "test/unit"

require File.dirname(__FILE__) + "/../lib/database"
require File.dirname(__FILE__) + "/../lib/quote"
require File.dirname(__FILE__) + "/../config/test"

class QuoteTest < Test::Unit::TestCase
  
  def setup
    assert_equal "quotes_test", db_select_one_value("select database()")
    db_execute "delete from comments"
    db_execute "delete from quotes"    
  end
  

  def test_find_all_quotes_returns_comments
    # first insert a quote with two comments
    quote_id = save_quote({"body" => "a body", "author" => "an author"})
    assert quote_id, "did not save?"
    create_comment({"author" => "a0", "body" => "b0", "quote_id" => quote_id})
    create_comment({"author" => "a1", "body" => "b1", "quote_id" => quote_id})
    
    # call find_all_quotes, should return 1 quote
    quotes = find_all_quotes()
    assert_equal 1, quotes.size
    
    # check that the quote contains our two comments
    q = quotes.first
    assert_equal 2, q["comments"].size
    assert_equal "b0", q["comments"][0]["body"]
    assert_equal "b1", q["comments"][1]["body"]
  end
end

