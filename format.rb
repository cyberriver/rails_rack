module Format
  DATE_DIRECTIVES = {'year'=> '%Y',
                     'month'=> '%m',
                     'day'=>'%d',
                     'hour'=>'%H',
                     'minute'=>'%M',
                     'second'=> '%S'}.freeze

  def has_format?(params) #method verify is any send "format"
    true if params.key?("format") && params["format"].size>0
  end


  def verify_params(params)
    @diff = find_difference(split_params(params))
    true if @diff.size == 0 #true if no unrecognized parameters
  end

  private

  def split_params(params) #split params into array
    params.split(',')
  end

  def find_difference(arr)
    arr - DATE_DIRECTIVES.to_a #find unrecognized parameters
  end


  def set_date_directives(params) #convert parameters for directives for Time class
    params.map! {|a| a = DATE_DIRECTIVES[a]}
    @options = params
    puts "params set_date_directives #{params}"
  end

end
