#!/usr/bin/env ruby

SERVICE_ROOT = File.dirname(__FILE__) + "/.."

require 'cgi'
require 'erb'
require "#{SERVICE_ROOT}/lib/quote"
require "#{SERVICE_ROOT}/lib/template"

cgi = CGI.new

printf "Content-type: text/html\r\n"
printf "\r\n"

quote, author = select_quote(cgi['q'])
template = load_template("index")

ERB.new(template).run
