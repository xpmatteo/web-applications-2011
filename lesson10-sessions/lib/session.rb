
SESSION_TIMEOUT_MINUTES=30

class Session
  attr_accessor :user_id, :session_id
  def initialize(session_id, user_id)
    @user_id = user_id
    @session_id = session_id
  end
  
  def save
    db_execute("update sessions set user_id = #{user_id} where session_id = #{@session_id}")
  end
end

def has_cookie(cgi, name)
  cgi.cookies[name].size > 0
end

def get_cookie(cgi, name)
  cgi.cookies[name][0]
end

def set_cookie(name, value)
  print "Set-Cookie: #{name}=#{value}; path=/\r\n"  
end

def start_session(cgi)
  if has_cookie(cgi, "session_id")
    session_id = get_cookie(cgi, "session_id").to_i
    user_id = db_select_one_value("
      select user_id 
      from sessions 
      where session_id = #{session_id}")
    return Session.new(session_id, user_id)
  else
    session_id = rand(1_000_000_000)
    set_cookie("session_id", session_id)
    db_execute("insert into sessions (session_id, created_at) values (#{session_id}, now())")
    return Session.new(session_id, nil)    
  end
end

def user_is_logged_in(session)
  ! session.user_id.nil?
end

def check_user_is_logged_in(session)
  unless user_is_logged_in(session)
    redirect "/users/login?requested_uri=#{CGI::escape(requested_uri)}"
  end
end
