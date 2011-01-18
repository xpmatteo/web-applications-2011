
DATA_FILE = "#{SERVICE_ROOT}/data/quotes.txt"

def find_all_quotes
  contents = File.open(DATA_FILE, "r") {|f| f.read }
  result = []
  index = 0
  for quote in contents.split("%")
    body, author = quote.split("--")
    result << { :body => body, :author => author, :quote_id => index }
    index += 1
  end
  result
end

def random_quote(array)
  if array.empty?
    quote = "Nessuna citazione disponibile"
  else
    quote, author = array[rand(array.size)].split("--")  
  end
end

def select_quote(search_param)
  contents = File.open(DATA_FILE, "r") {|f| f.read }
  all_quotes = contents.split("%")
  if search_param
    filtered_quotes = all_quotes.select {|q| q.downcase.include?(search_param.downcase)}
    quote, author = random_quote(filtered_quotes)
  else
    quote, author = random_quote(all_quotes)
  end  
end

def save_quote(author, body, errors)
  errors['author'] = "Sforziamoci di mettere un autore, ok?" if missing(author)
  errors['body'] = "Un testo per cortesia" if missing(body)
  return false unless errors.empty?

  File.open(DATA_FILE, "a") do |f|
    f.puts "%"
    f.puts body
    f.puts "\n-- #{author}\n"
  end
  return true
end

def missing value
  value.nil? || value.empty?
end
