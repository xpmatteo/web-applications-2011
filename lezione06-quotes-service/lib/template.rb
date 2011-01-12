

def load_template(name)
  File.open("#{SERVICE_ROOT}/templates/#{name}.rhtml", "r") {|f| f.read}
end