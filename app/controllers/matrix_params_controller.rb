class MatrixParamsController < ApplicationController
  require 'json'


  # GET /matrix_params
  # GET /matrix_params.json
	
  def index
  
    @matrix_config = MatrixConfig.find(params[:matrix_config_id])
    @has_results = @matrix_config.has_results
    @group = @matrix_config.group
    @matrix_params = @matrix_config.matrix_params
    @name=@matrix_config.name+"-Results"
    @count = 0
    i = 0
    while i<@matrix_params.count do
	matrix_values = @matrix_params[i].matrix_values
	if matrix_values.count > @count
		@count =matrix_values.count
	end
    i+=1
    end
   #generate Case start

   #generate Case end
  
    ### added by huangym ###
        hash = Hash.new
	arry = Array.new

	@matrix_params.each do |matrix_param|
		h = Hash.new
		h["name"] = matrix_param.parameter.name
		h["weight"] = matrix_param.parameter.weight
		
		a = Array.new
		matrix_param.matrix_values.each do |matrix_value|	
			h1 = Hash.new
			h1["value"] = matrix_value.value.value
			h1["weight"] = matrix_value.weight
			a << h1			
		
		end
		h["values"] = a
		arry << h
		
	end

	hash["parameters"] = arry


	arr = Array.new
	@matrix_config.limit_pairs.each do |pair|
		h = Hash.new
		h["first_parameter"] = Value.find(pair.first_value_id).value
		h["second_parameter"] = Value.find(pair.second_value_id).value
		arr << h
	end
	hash["Invalid pairs"]=arr

	@jsonStr = hash.to_json

    ###   end  ###

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @matrix_params }
    end
  end


  # GET /matrix_params/1
  # GET /matrix_params/1.json
  def show
    puts params[:id]
    @matrix_param = MatrixParam.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @matrix_param }
    end
  end

  # GET /matrix_params/new
  # GET /matrix_params/new.json
  def new
     
     @parameter = Parameter.new #if user chose new a parameter then he can create a new parameter
     @parameter.is_default = false
     @matrix_config = MatrixConfig.find(params[:matrix_config_id]) #if user chose select parameter  from system then we should allow he do that
     @matrix_param = @matrix_config.matrix_params.new
     @sysparameters = Parameter.find_by_sql ["select * from parameters where id not in (select parameter_id from matrix_params where matrix_config_id=:matrix_id)",{:matrix_id=>params[:matrix_config_id]} ]

     #do by chuangye start
     #@sysparameters = Parameter.where("is_default=true")  #select the system parameter from database
    #do by chuangye end
     @group = Group.find(@matrix_config.group_id)          #select the group parameter from database
 
    



    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @matrix_param }
    end
  end

  # GET /matrix_params/1/edit
  def edit
    @matrix_param = MatrixParam.find(params[:id])
     @sysparameters = Parameter.where("is_default=true")  #select the system parameter from database
	@matrix_config = @matrix_param.matrix_config    
     @group = Group.find(@matrix_config.group_id)          #select the group parameter from database
	
  end

  # POST /matrix_params
  # POST /matrix_params.json
   def create
    
    @matrix_param = MatrixParam.new(params[:matrix_param])
    @reqparameter_id = params[:sysparameter_id]
    matrix_config = MatrixConfig.find(@matrix_param.matrix_config_id)
    group = matrix_config.group
    #@matrix_config = MatrixConfig.find(params[:matrix_config_id])

    if @reqparameter_id.to_i==0 #user new a group parameter
        #new parameter
	########## added by huangym ######
	parameter = Parameter.find_by_name(params[:name])
	if parameter==nil
		@parameter = Parameter.new()	
       		@parameter.name = params[:name]	
	 	@parameter.is_default = false
		@parameter.weight = params[:weight]
		@parameter.status = 0
		@parameter.save
		parameter = @parameter
	end                 
	@matrix_param.parameter_id = parameter.id
        group_parameter = GroupParameter.new
	group_parameter.group_id = group.id
	group_parameter.parameter_id = parameter.id
	group_parameter.save  #if the group_parameter exists, then save failed.
=begin
	#build group and parameter relationship
	matrix_config = MatrixConfig.find(@matrix_param.matrix_config_id)
	@group = Group.find(matrix_config.group_id)
	@group_parameter = @group.group_parameters.build(:parameter_id=>parameter)
	@group_parameter.save
=end

    else 
	@matrix_param.parameter_id = params[:sysparameter_id]
    end
	

    respond_to do |format|
      if @matrix_param.save 
 	#format.html { redirect_to @matrix_param, notice: 'Matrix param was successfully created.' }
        #format.html { redirect_to matrix_param_path(:matrix_config_id=>@matrix_param.matrix_config_id)}
        format.html { redirect_to :action=>'index',:matrix_config_id=>@matrix_param.matrix_config_id}
        #format.json { render json: @matrix_param, status: :created, location: @matrix_param }
        navTabName='#{group.name+matrix_config.name}'
	format.json { render :json=>{'statusCode'=>'200','message'=>'Add Parameter Success!','navTabId'=>navTabName,'rel'=>'','callbackType'=>'closeCurrent','forwardUrl'=>''} }
      else
        #format.html { render action: "new" }
        format.json { render json: @matrix_param.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /matrix_params/1
  # PUT /matrix_params/1.json
  def update
    @matrix_param = MatrixParam.find(params[:id])


    hash = params[:weight]
    matrix_config_id=0
    hash.each_key do |key|
	matrix_value = MatrixValue.find(key.to_i)
	matrix_value.weight = hash[key].to_f
	matrix_value.save
	matrix_config_id = matrix_value.matrix_param.matrix_config.id
    end



    respond_to do |format|
      if @matrix_param.update_attributes(params[:matrix_param])
        #format.html { redirect_to @matrix_param, notice: 'Matrix param was successfully updated.' }
#        format.json { head :no_content }
	format.html { redirect_to matrix_params_path(:matrix_config_id=>@matrix_param.matrix_config_id)}
	format.json { render :json=>{'statusCode'=>'200','message'=>'Edit Parameter Success!','navTableId'=>'','rel'=>'','callbackType'=>'','forwardUrl'=>'','confirmMsg'=>''} }

      else
        format.html { render action: "edit" }
        format.json { render json: @matrix_param.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /matrix_params/1
  # DELETE /matrix_params/1.json
  def destroy
    @matrix_param = MatrixParam.find(params[:param_id])
     @matrix_config = MatrixConfig.find(@matrix_param.matrix_config_id)
	@group = Group.find(@matrix_config.group_id)
    @user = User.find(@group.user_id)
    matrix_config_id = @matrix_param.matrix_config_id
    @matrix_param.destroy
    respond_to do |format|
    format.html { redirect_to :action=>'index',:matrix_config_id=>@matrix_param.matrix_config_id }
     #format.html { redirect_to groups_url(:user_id=>@user.id) }

#format.html { render :action=>'index', :layout=>"mainlayout"}
      format.json { render :json=>{'statusCode'=>'200','message'=>'Delete Success!','navTabID'=>'','rel'=>'','callbackType'=>'closeCurrent','forwardUrl'=>''} }
    end
  end
 def del
      print "ffffffffff"
      @matrix_param = MatrixParam.find(params[:id])
      print"99999999999999999"
      print params[:id]
 end



   # added by huangym

  def import
	@matrix_config = MatrixConfig.find(params[:matrix_config_id])
	navTabName=@matrix_config.group.name+@matrix_config.name
        if params[:jsonStr]!=nil
		str = params[:jsonStr]
	else

	file = params[:file]
	if file== nil
		respond_to do |format|
			#format.json{ render :json => {'statusCode' => '200', 'message' => 'Import parameters success!', 'rel'=>'', 'callbackType' =>'','forwardUrl'=>'' } }
			#format.html { redirect_to :action=>'index',:matrix_config_id=>@matrix_config.id}
      		end
		return
	end
	puts file.size

	test = file.read
        str = test.to_s
	end

        puts str
	puts "@@@"
        
	####  parse json string, update database
        begin
	result = JSON.parse(str)
        puts "&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&"
	puts result.to_s
	parameters = result["parameters"]
	invalidPairs = result["Invalid pairs"]
	puts parameters

	####################################################### import parameters
        # if the matrix_config has parameters, then destroy
        if @matrix_config.matrix_params!= nil
		@matrix_config.matrix_params.each do |matrix_param|
			matrix_param.destroy
		end
	end

	for i in 0..parameters.length-1 do
		puts i
		name = parameters[i]["name"]
		weight = parameters[i]["weight"]
		puts name

		# parameter
		param = Parameter.find_by_name(name)
                if param == nil
			param = Parameter.new
			param.name = name
			param.weight = weight
			param.save
 		end
		
		# group_parameter
		group_parameter = GroupParameter.find(:first,:conditions=>["group_id =? and parameter_id =?", @matrix_config.group_id, param.id])
		if group_parameter == nil
			group_parameter = GroupParameter.new
			group_parameter.group_id = @matrix_config.group_id
			group_parameter.parameter_id= param.id
			group_parameter.save
		end

		# matrix_param
		matrix_param = MatrixParam.new
		matrix_param.matrix_config_id = @matrix_config.id
		matrix_param.parameter_id = param.id
		matrix_param.save
	
		values = parameters[i]["values"]
		puts values
		for j in 0..values.length-1 do
			valueV = values[j]["value"]
			valueW = values[j]["weight"]
			puts valueV

			# value
			value=Value.find_by_value(valueV)
			if value == nil
				value = Value.new
				value.value = valueV
				value.weight = valueW
				value.parameter_id = param.id
				value.save
			end

			# matrix_value
			matrix_value = MatrixValue.new
			matrix_value.matrix_param_id = matrix_param.id
			matrix_value.value_id = value.id	
			matrix_value.weight = valueW
			matrix_value.save
		end
		
	#	respond_to do |format|
			#format.json{render :json=>{ 'statusCode' =>'200', 'message'=>'Add records succeed!','navTabID' => 'calculation', 'rel' =>'forward' , 'forwardUrl'=>'calculation' }}
			#format.json{ render :json => {'statusCode' => '200', 'message' => 'Import parameters success!', 'rel'=>'', 'callbackType' =>'','forwardUrl'=>'' } }
			#format.html { redirect_to :action=>'index',:matrix_config_id=>@matrix_config.id}
      	#	end
		message ="Import parameters succedd!"	
		flag=0
	end

	###################################################### import invalid pairs
	if @matrix_config.limit_pairs!=nil
		@matrix_config.limit_pairs.each do |limit_pair|
			limit_pair.destroy
		end
	end

	logger.info(invalidPairs.to_s)
	for i in 0...invalidPairs.length do
		fvalue=invalidPairs[i]["first_parameter"]
		svalue=invalidPairs[i]["second_parameter"]
		limit_pair = LimitPair.new
		fv=Value.find_by_value(fvalue)
		limit_pair.first_value_id = fv.id
		sv= Value.find_by_value(svalue)
		limit_pair.second_value_id =sv.id
		limit_pair.matrix_config_id = @matrix_config.id
		limit_pair.save
		
	end


	rescue
		puts "failed"
		message = "Import parameters failed! Please check the json string."
		flag =1
	#	render :text => "Import parameters failed! Please check the json string."
	end
         
	if flag==1
		render :text => "Import parameters failed! Please check the json string."
	else
		respond_to do |format|
			format.json{ render :json => {'statusCode' => '200', 'message' =>message, 'navTabId'=>navTabName,'config_id'=>@matrix_config.id, 'url'=>'/matrix_params/index'}}
		end
	end

	
=begin
        respond_to do |format|
		
		format.json{ render :json => {'statusCode' => '200', 'message' => 'Import parameters success!', 'rel'=>'', 'callbackType' =>'','forwardUrl'=>'' } }

       	#	format.html { redirect_to :action=>'index',:matrix_config_id=>@matrix_config.id}
	#	group = @matrix_config.group
           #     navTabName='#{group.name+@matrix_config.name}'
#		format.json { render :json=>{'statusCode'=>'200','message'=>'Import Parameter Success!','navTabId'=>navTabName,'rel'=>'','callbackType'=>'closeCurrent','forwardUrl'=>''} }
       	#	format.json { render json: @matrix_param.errors, status: :unprocessable_entity }

      end
=end
  end

  def export
	@matrix_config = MatrixConfig.find(params[:matrix_config_id])
        @matrix_params = @matrix_config.matrix_params

	hash = Hash.new
	arry = Array.new

	@matrix_params.each do |matrix_param|
		h = Hash.new
		h["name"] = matrix_param.parameter.name
		h["weight"] = matrix_param.parameter.weight
		
		a = Array.new
		matrix_param.matrix_values.each do |matrix_value|	
			h1 = Hash.new
			h1["value"] = matrix_value.value.value
			h1["weight"] = matrix_value.weight
			a << h1			
		
		end
		h["values"] = a
		arry << h
		
	end

	hash["parameters"] = arry
        arr = Array.new
	@matrix_config.limit_pairs.each do |pair|
		h = Hash.new
		h["first_parameter"] = Value.find(pair.first_value_id).value
		h["second_parameter"] = Value.find(pair.second_value_id).value
		arr << h
	end
	hash["Invalid pairs"]=arr

	@jsonStr = hash.to_json

        send_data(@jsonStr, options={:type => 'text', :disposition => "attachment", :filename => "json.txt"})

  end


end
