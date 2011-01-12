#!/usr/bin/env ruby

require 'cgi'
require 'erb'

cgi = CGI.new

printf "Content-type: text/html\r\n"
printf "\r\n"

@posts = ["aa", "bb"]

template = <<-EOTEMPLATE
  <% for post in @posts %>
  <p><%= post %></p>
  <% end %>
EOTEMPLATE

ERB.new(template).run
