require "test/unit"

require File.dirname(__FILE__) + "/../lib/database"
require File.dirname(__FILE__) + "/../config/test"

class DatabaseTest < Test::Unit::TestCase
  
  def test_connection
    assert connection
    assert_equal "quotes_test", db_select_one_value("select database()")
  end
  
  def test_select
    actual = db_select "select 2 + 2"
    assert_equal [{"2 + 2" => "4"}], actual
  end
  
  def test_select_one
    assert_equal "6", db_select_one_value("select 2 * 3")
  end
  
  def test_execute
    db_execute "drop table if exists pippo"
    db_execute "create table pippo (a int)"
    assert_equal "0", db_select_one_value("select count(*) from pippo")
  end
  
  def test_db_insert
    db_execute "drop table if exists pippo"
    db_execute "create table pippo (a integer auto_increment primary key)"
    
    new_id = db_insert "insert into pippo (a) values (null)"
    assert_equal "1", new_id
    
    new_id = db_insert "insert into pippo (a) values (null)"
    assert_equal "2", new_id
  end
end

