require 'rack'
require_relative 'time_formatter'

class App

  def call(env)
    request = Rack::Request.new(env)
    #filtering request by incorrect parameters
    if request.params != {}
      time_formatter = TimeFormatter.new(request)            
      if time_formatter.invalid?
        response(time_formatter.call,404,headers)
      else 
        reponse(time_formatter.call,200,headers)
      end
    else      
      response("Request has no parameters"+"\n", 400, headers)    
    end

  end

  private
  #filtering request by incorrect parameters
  def headers
    { "Content-Type" => "text/plain" }    
  end

  def response (body, status, headers)
    Rack::Response.new(
      body, status, headers
    ).finish
  end

end
