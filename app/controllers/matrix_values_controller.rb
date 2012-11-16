class MatrixValuesController < ApplicationController
  # GET /matrix_values
  # GET /matrix_values.json
  def index
#    @matrix_values = MatrixValue.all

    @matrix_param = MatrixParam.find(params[:matrix_param_id])
    @matrix_values = @matrix_param.matrix_values

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @matrix_values }
    end
  end

  # GET /matrix_values/1
  # GET /matrix_values/1.json
  def show
    @matrix_value = MatrixValue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @matrix_value }
    end
  end

  # GET /matrix_values/new
  # GET /matrix_values/new.json
  def new
   # @matrix_value = MatrixValue.new
     @value = Value.new #if user chose new a parameter then he can create a new parameter
     @value.is_default = false

     @matrix_param = MatrixParam.find(params[:matrix_param_id]) #if user chose select parameter  from system then we should allow he do that

     @matrix_value = @matrix_param.matrix_values.new

     #@sysvalues = Value.where("parameter_id='#{@matrix_param.parameter_id}'")  #select the system parameter from database
     @sysvalues = Value.find_by_sql ["select * from `values` where parameter_id =:parameter_id and id not in(select value_id from matrix_values where matrix_param_id=:matrix_param_id )",{:parameter_id=>@matrix_param.parameter_id,:matrix_param_id=>params[:matrix_param_id]}]
   



    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @matrix_value }
    end
  end

  # GET /matrix_values/1/edit
  def edit
    @matrix_value = MatrixValue.find(params[:id])
  end

  # POST /matrix_values
  # POST /matrix_values.json
  def create
   

    @matrix_value = MatrixValue.new(params[:matrix_value])
    @reqvalue_id = params[:sysvalue_id]

    if @reqvalue_id.to_i==0 #user new a group value
        #new value
        # added by huangym
        
        value = Value.find_by_value(params[:value])
	if value==nil
		@value = Value.new()	
                @value.value = params[:value]
	        @value.is_default = false
       		@value.weight = params[:weight]
	        @value.status = 0
        	@value.save
		value = @value
	end		
	matrix_param = MatrixParam.find(@matrix_value.matrix_param_id)
        value.parameter_id = matrix_param.parameter_id
	value.save
	@matrix_value.value_id = value.id
=begin
        @value.value = params[:value]	
 	@value.is_default = false
	@value.weight = params[:weight]
	@value.status = 0
	@value.save
	@matrix_value.value_id = @value.id

	#build group and values relationship
	matrix_param = MatrixParam.find(@matrix_value.matrix_param_id)
	matrix_config = MatrixConfig.find(matrix_param.matrix_config_id)

	@group = Group.find(matrix_config.group_id)
	@group_value = @group.group_values.build(:value_id=>@value)
	@group_value.save
=end
    else 
	@matrix_value.value_id = params[:sysvalue_id]
#	@matrix_value.matrix_param_id = Value.find_by_id(params[:sysvalue_id]).parameter_id
    end
    #@matrix_value.weight = params[:weight]
    #@matrix_value.is_chosen = 1

    matrix_param = MatrixParam.find(@matrix_value.matrix_param_id)
    matrix_config = MatrixConfig.find(matrix_param.matrix_config_id)

    # add by huangym
    logger.info(matrix_param.matrix_values.count)
    count = matrix_param.matrix_values.count+1

    lastweight=1    
    matrix_param.matrix_values.each do |matrix_value|
	matrix_value.weight = (1.to_f/count.to_f).round(4)
	matrix_value.save
	lastweight = lastweight-matrix_value.weight
    end
    @matrix_value.weight=lastweight
    # add end


## @matrix_value = MatrixValue.new(params[:matrix_value])

    respond_to do |format|
      if @matrix_value.save
       # format.html { redirect_to @matrix_value, notice: 'Matrix value was successfully created.' }
	format.html { redirect_to matrix_params_path(:matrix_config_id=>matrix_param.matrix_config_id)}
#       format.json { render json: @matrix_value, status: :created, location: @matrix_value }
	format.json { render :json=>{'statusCode'=>'200','message'=>'Add Value Success!','navTableId'=>'','rel'=>'','callbackType'=>'','forwardUrl'=>'','confirmMsg'=>''} }
      else
        #format.html { render action: "new" }
        format.json { render json: @matrix_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /matrix_values/1
  # PUT /matrix_values/1.json
  def update
  ########## added by huangym  ##########
  hash = params[:weight]
  matrix_config_id=0
  hash.each_key do |key|
	matrix_value = MatrixValue.find(key.to_i)
	matrix_value.weight = hash[key].to_f
	matrix_value.save
	matrix_config_id = matrix_value.matrix_param.matrix_config.id
  end
  

  respond_to do |format|
	format.html { redirect_to matrix_params_path(:matrix_config_id=>matrix_config_id)}
	format.json { render :json=>{'statusCode'=>'200','message'=>'Edit Value Success!','navTableId'=>'','rel'=>'','callbackType'=>'','forwardUrl'=>'','confirmMsg'=>''} }
  end

=begin
   @matrix_value = MatrixValue.find(params[:id])
   matrix_config_id = @matrix_value.matrix_param.matrix_config.id
    respond_to do |format|
      if @matrix_value.update_attributes(params[:matrix_value])
        #format.html { redirect_to @matrix_value, notice: 'Matrix value was successfully updated.' }
format.html { redirect_to matrix_params_path(:matrix_config_id=>matrix_config_id)}
#        format.json { head :no_content }
format.json { render :json=>{'statusCode'=>'200','message'=>'Edit Value Success!','navTableId'=>'','rel'=>'','callbackType'=>'','forwardUrl'=>'','confirmMsg'=>''} }
      else
        format.html { render action: "edit" }
        format.json { render json: @matrix_value.errors, status: :unprocessable_entity }
      end
    end
=end

  ########  end  ########
  end

  # DELETE /matrix_values/1
  # DELETE /matrix_values/1.json
  def destroy
    @matrix_value = MatrixValue.find(params[:id])
    matrix_config_id = @matrix_value.matrix_param.matrix_config.id
    @matrix_config = MatrixConfig.find(matrix_config_id)
    @group = Group.find(@matrix_config.group_id)
    @user = User.find(@group.user_id)
    @matrix_value.destroy

    respond_to do |format|
#      format.html { redirect_to matrix_values_url(:matrix_config_id=>matrix_config_id) }
      format.html { redirect_to groups_url(:user_id=>@user) }
      format.json { head :no_content }
    end
  end
end
