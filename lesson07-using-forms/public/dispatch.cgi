#!/usr/bin/env ruby

SERVICE_ROOT = File.dirname(__FILE__) + "/.."

require 'cgi'
require 'erb'
require "#{SERVICE_ROOT}/lib/quote"
require "#{SERVICE_ROOT}/lib/template"
require "#{SERVICE_ROOT}/lib/html_helpers"

params = CGI.new
errors = {}

case requested_uri
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
  if save_quote params['author'], params['body'], errors
    redirect "/"
  else
    render "new"
  end
else
  quote, author = select_quote(params['q'])
  render "index"
end
