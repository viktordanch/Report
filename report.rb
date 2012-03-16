require 'rubygems'
require 'sinatra'
require 'config/database_setup'
require 'lib/models/users'


enable :sessions

helpers do
  def require_login
    halt [404, "not_found"] unless session["user"]
    session["user"]
  end
  def require_user
    require_login
    halt [404, "not_found"] if session["user"] == "login"
    session["user"]  
  end
  def current_user
    User.find_by_id(session['user'])
  end
end


get '/logout' do
  session['user'] = nil
  redirect "/"
end


get '/' do
 erb :home  
end


post '/registration' do
  erb :registration 
end

post '/save' do
 registration(params["password"], params["apassword"], params["login"], params)
end

post '/verification' do
 enter(params["login"],params["password"])
end

post '/enter' do
 erb :work
end

post '/project' do
 erb :project;
end

post '/saveproject' do
 saveproject(params)
 
end

post '/addrecord' do
 erb :addrecord;
end

post '/saverecord' do
 saverecord(params)

end

post '/newdate' do
 newdate(params)
 
end

post '/monthview' do
 erb :month
end

post '/delete' do
 funcdelete(params)
end
