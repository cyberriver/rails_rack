require 'rack'
require_relative 'format'

class App
include Format

  def call(env)
    request = Rack::Request.new(env)
    #filtering request by incorrect parameters
    if request.params != {}
      main_check(request) 
    else
      incorrect_parameters("Request has no parameters"+"\n")    
    end

  end

  private
  #filtering request by incorrect parameters
  def main_check(request)
    if check_params(request)
      set_date_directives(split_params(request.params["format"]))
      serve_request(request.params)
    else
      incorrect_parameters(@diff) #filtering request by incorrect parameters
    end
  end

  def check_params(request)
    params = request.params
    verify_params(params["format"]) if has_format?(params) if params.size >0
  end

  def serve_request(params)  
    msg = Time.now.strftime(params.join('-')).to_s if params !=nil
    response(msg, 200,{ "Content-Type" => "text/plain" })  
    
  end

  def incorrect_parameters(args)
    msg = "Unknown time format #{args}"+"\n"
    response(msg, 400, { "Content-Type" => "text/plain" })
  end

  def response (body, status, headers)
    Rack::Response.new(
      body, status, headers
    ).finish
  end

end
