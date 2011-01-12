#!/usr/bin/env ruby

require 'cgi'
require 'erb'

cgi = CGI.new

printf "Content-type: text/html\r\n"
printf "\r\n"

printf "Hello, world!"