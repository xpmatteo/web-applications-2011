
def requested_uri
  remove_query_string ENV['REQUEST_URI']
end

def remove_query_string uri
  uri.sub(/\?.*$/, "")
end

def load_template(name)
  File.open("#{SERVICE_ROOT}/templates/#{name}.rhtml", "r") {|f| f.read}
end

def render(template_name)
  template = load_template(template_name)
  
  printf "Content-type: text/html\r\n"
  printf "\r\n"

  @content_for_layout = ERB.new(template).result
  
  puts ERB.new(load_template("layout")).result
end

def redirect(location)
  printf "Location: http://#{ENV['HTTP_HOST']}#{location}\r\n"
  render "redirect"  
end

def protect_in_html(string)
  string.gsub("'", "&apos;")
end