require "test/unit"

require File.dirname(__FILE__) + "/../lib/html_helpers"

class HtmlHelpersTest < Test::Unit::TestCase
  def test_input_text_field
    expected = "<p><label for='aName'>a label</label><br/><input  type='text' name='aName' value='a value'/></p>"
    assert_equal expected, input_text_field("a label", "aName", "a value", errors = {})
  end

  def test_input_hidden_field
    expected = "<input type='hidden' name='someName' value='the value' />"
    assert_equal expected, input_hidden_field("someName", "the value")
  end
  
  def test_submit_button
    expected = "<p><input type='submit' value='a label' /></p>"
    assert_equal expected, submit_button("a label")
  end
  
end