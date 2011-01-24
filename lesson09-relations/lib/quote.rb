
DATA_FILE = "#{SERVICE_ROOT}/data/quotes.txt"

def find_all_quotes
  db_select "select * from quotes order by quote_id"
end

def find_quote(quote_id)
  quotes = db_select "select * from quotes where quote_id = #{quote_id.to_i}"
  quotes.first || default_quote
end

def find_comments(quote_id)
  [
    {"body" => "bello", "author" => "Gino", "created_at" => Time.local(2007,2,14,4,55)},
    {"body" => "fa schifo", "author" => "Topolino", "created_at" => Time.local(2009,2,13,17,5)},
  ]
end

def find_random_quote(search_param)
  if search_param
    where = "where body like '%#{protect(search_param)}%'"
  else
    where = ""
  end
  quotes = db_select "select * from quotes #{where} order by rand() limit 1"  
  quotes.first || default_quote
end

def save_quote(quote, errors)
  errors['author'] = "Sforziamoci di mettere un autore, ok?" if missing(quote["author"])
  errors['body'] = "Un testo per cortesia" if missing(quote["body"])
  return false unless errors.empty?

  sql = sprintf(
    "insert into quotes (body, author) values ('%s', '%s')",
    protect(quote["body"]),
    protect(quote["author"])
  )
  return db_insert(sql)
end

def default_quote
  { "body" => "Nessuna citazione disponibile" }
end

def protect(string)
  string.gsub("'", "\\'")
end

def missing value
  value.nil? || value.empty?
end

