#!/usr/bin/env ruby

SERVICE_ROOT = File.dirname(__FILE__) + "/.."

require 'cgi'
require 'erb'
require "#{SERVICE_ROOT}/config/current_configuration"
require "#{SERVICE_ROOT}/lib/database"
require "#{SERVICE_ROOT}/lib/html_helpers"
require "#{SERVICE_ROOT}/lib/quote"
require "#{SERVICE_ROOT}/lib/session"
require "#{SERVICE_ROOT}/lib/template"
require "#{SERVICE_ROOT}/lib/user"

cgi = CGI.new

params = cgi
errors = {}

if has_cookie(cgi, "visits")
  visits = get_cookie(cgi, "visits").to_i
  visits += 1
else
  visits = 0
end
set_cookie("visits", visits)

session = start_session(cgi)

case requested_uri
when "/quotes/comments/create"
  create_comment(params)
  redirect "/?quote_id=#{params ["quote_id"]}"
when "/quotes/list"
  quotes = find_all_quotes
  render "list"
when "/quotes/edit"
  check_user_is_logged_in(session)
  quote = find_quote(params["quote_id"])
  render "edit"
when "/quotes/update"
  check_user_is_logged_in(session)
  if update_quote params, errors
    redirect "/?quote_id=#{params["quote_id"]}"
  else
    render "edit"
  end
when "/quotes/edit"
  render "edit"
when "/quotes/new"
  check_user_is_logged_in(session)
  render "new"
when "/quotes/create"
  check_user_is_logged_in(session)
  if quote_id = save_quote(params, errors)
    redirect "/?quote_id=#{quote_id}"
  else
    render "new"
  end
when "/users/login"
  render "login"
when "/users/authenticate"
  if user_id = authenticate(params)
    session.user_id = user_id
    session.save
    redirect params["requested_uri"] || "/"
  else
    errors["base"] = "failed authentication"
    render "login"
  end
when "/"
  if params["quote_id"] && !params["quote_id"].empty?
    quote = find_quote(params["quote_id"])
  else    
    quote = find_random_quote(params['q'])
  end
  render "index"
else
  print "Status: 404 Not Found\r\n"
  render "404"
end
