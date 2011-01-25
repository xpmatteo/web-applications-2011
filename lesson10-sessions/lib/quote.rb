
def find_all_quotes
  quotes = db_select "select * from quotes order by quote_id limit 100"
  # N+1 queries!!! bad performance !!! Don't do this
  for quote in quotes
    add_comments(quote)
  end
end

def find_quote(quote_id)
  quotes = db_select "select * from quotes where quote_id = #{quote_id.to_i}"
  add_comments(quotes.first || default_quote)
end

def find_random_quote(search_param)
  if search_param
    where = "where body like '%#{protect(search_param)}%'"
  else
    where = ""
  end
  quotes = db_select "select * from quotes #{where} order by rand() limit 1"  
  add_comments(quotes.first || default_quote)
end

def save_quote(quote, errors={})
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

def create_comment(params)
  sql = sprintf "insert into comments (quote_id, body, author, author_url, created_at) 
    values (%s, '%s', '%s', '%s', now())", 
    protect(params["quote_id"]),
    protect(params["body"]),
    protect(params["author"]),
    protect(params["author_url"])
  db_execute sql
end

private

def default_quote
  { "body" => "Nessuna citazione disponibile" }
end

def protect(string)
  string && string.gsub("'", "\\'") 
end

def missing value
  value.nil? || value.empty?
end

def add_comments(quote)
  quote["comments"] = 
    db_select("select * 
               from comments 
               where quote_id = #{quote["quote_id"]}
               order by created_at")
  quote
end

