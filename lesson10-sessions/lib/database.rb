
require 'rubygems'
require 'mysql'

def connection
  @connection ||= Mysql.connect(DB_HOST, DB_USERNAME, DB_PASSWORD, DB_NAME)
end

def db_select(sql)
  rows = connection.query(sql)
  result = []
  rows.each_hash do |row|
    result << row
  end
  rows.free
  result
end

def db_select_one_value(sql)
  db_select(sql).first.values.first
end

def db_execute(sql)
  connection.query(sql)
end

def db_insert(sql)
  connection.query(sql)
  db_select_one_value("select last_insert_id()")
end