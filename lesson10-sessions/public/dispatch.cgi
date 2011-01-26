#!/usr/bin/env ruby

SERVICE_ROOT = File.dirname(__FILE__) + "/.."

require 'cgi'
require 'erb'
require "#{SERVICE_ROOT}/config/current_configuration"
require "#{SERVICE_ROOT}/lib/quote"
require "#{SERVICE_ROOT}/lib/template"
require "#{SERVICE_ROOT}/lib/database"
require "#{SERVICE_ROOT}/lib/html_helpers"

cgi = CGI.new
params = cgi
errors = {}

case requested_uri
when "/quotes/comments/create"
  create_comment(params)
  redirect "/?quote_id=#{params ["quote_id"]}"
when "/quotes/list"
  quotes = find_all_quotes
  render "list"
when "/quotes/edit"
  quote = find_quote(params["quote_id"])
  render "edit"
when "/quotes/update"
  if update_quote params["quote_id"], params['author'], params['body'], errors
    redirect "/"
  else
    render "edit"
  end
when "/quotes/new"
  render "new"
when "/quotes/create"
  if quote_id = save_quote(params, errors)
    redirect "/?quote_id=#{quote_id}"
  else
    render "new"
  end
when "/"
  if params["quote_id"]
    quote = find_quote(params["quote_id"])
  else    
    quote = find_random_quote(params['q'])
  end
  render "index"
else
  print "Status: 404 Not Found\r\n"
  render "404"
end
