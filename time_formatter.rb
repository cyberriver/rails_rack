class TimeFormatter

  attr_reader :valid, :invalid

  DATE_DIRECTIVES = {"year"=> "%Y",
                     "month"=> "%m",
                     "day"=>"%d",
                     "hour"=>"%H",
                     "minute"=>"%M",
                     "second"=> "%S"}.freeze
 
  def initialize(request)
    @request = request
    @valid = []
    @invalid = [] 
  end

  def call
    if success?
      "#{time_string}" + "\n" 
    else
      "#{@invalid}" + "\n"
    end
  end

  def invalid?
    @invalid.empty? 
  end

  private

  def success?    
    verify_params?(@request.params["format"]) if has_format?(@request.params)
  end

  def has_format?(params) #method verifies is there correct "format"
    true if params.key?("format") && params["format"].size>0
  end

  def verify_params?(params) #method verifies parameters
    data = split_params(params).to_a
  
    if find_difference(data).empty?     
      @valid = data
    else
      @invalid = data        
    end    
          
    true if @invalid.empty? #true if no unrecognized parameters
  end

  def split_params(params) #split params into array
    params.split(',')
  end

  def find_difference(arr)
     arr - DATE_DIRECTIVES.keys #find unrecognized parameters in compare with date directions
  end

  def set_date_directives #convert parameters for directives for Time class to calculate time string
    @valid.map! {|a| a = DATE_DIRECTIVES[a]}   
  end

  def time_string
    Time.now.strftime(set_date_directives.join('-')).to_s  
  end

end
