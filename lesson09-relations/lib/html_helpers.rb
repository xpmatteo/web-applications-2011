
def class_for_input_field(field_name, errors)
  if errors[field_name]
    "class='field_with_errors'" 
  else
    ""
  end
end

def input_text_field(label, name, value, errors)
  result = "<p>"
  result += "<label for='#{name}'>#{label}</label>"
  result += "<br/>"
  result += "<input " + class_for_input_field(name, errors) +
    " type='text' name='#{name}' value='#{value}'/>"
  result += "</p>"
  result
end

def input_hidden_field(name, value)
  sprintf "<input type='hidden' name='%s' value='%s' />", name, value
end

def submit_button(label)
  sprintf "<p><input type='submit' value='%s' /></p>", label
end