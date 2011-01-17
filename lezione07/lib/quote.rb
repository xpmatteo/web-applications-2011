
DATA_FILE = "#{SERVICE_ROOT}/data/quotes.txt"

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
