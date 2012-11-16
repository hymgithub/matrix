class ExportxlsController < ApplicationController
  def export


    headers['Content-Type'] = "application/vnd.ms-excel"
    headers['Content-Disposition'] = 'attachment; filename="report.xls"'
    headers['Cache-Control'] = ''
    @matrix_config = MatrixConfig.find(params[:matrix_config_id])
    @group = @matrix_config.group
    @matrix_params = @matrix_config.matrix_params
    @count = 0
    i = 0
    while i<@matrix_params.count do
	matrix_values = @matrix_params[i].matrix_values
	if matrix_values.count > @count
		@count =matrix_values.count
	end
    i+=1
    end


  end

def exportresults

    headers['Content-Type'] = "application/vnd.ms-excel"
    headers['Content-Disposition'] = 'attachment; filename="report.xls"'
    headers['Cache-Control'] = ''
   @flag=params[:tag]
    if params[:tag]=="hasid" #add by chuangye
               @selectedvalue_id = params[:value_id]
		@sbili = params[:sbili]
		@tbili = params[:tbili]
		@selectedparameter_id = Value.find(@selectedvalue_id).parameter_id
		@selectedparameterindex = -1		
   end	

		@matrix_config = MatrixConfig.find(params[:matrix_config_id])
		group = Group.find(@matrix_config.group_id)
		
		 @user = User.find(group.user_id)
		 @groups = @user.groups

		@matrix_params = @matrix_config.matrix_params

					@costtime
					paramsnum = @matrix_params.count

		 @width = 100/(paramsnum+2.to_f)
					@manager = Manager.new
					starttime = Time.now
			i=0
			 while i < paramsnum do   
			       temparameter = BParameter.new (@matrix_params[i].parameter.id)
				vlen = @matrix_params[i].matrix_values.count
				if params[:tag]=="hasid" #add by chuangye
				    if @matrix_params[i].parameter.id == @selectedparameter_id
					@selectedparameterindex = i
                                    end
				end  #add by ycy
				for j in 0...vlen.to_i do # input the value for current parameter 
				       element = Element.new @matrix_params[i].matrix_values[j].value.id,0
				       element.setweight @matrix_params[i].matrix_values[j].weight

				       temparameter.addElement element
				      end
				     @manager.parameters.paramsArr <<  temparameter  #store the temparameter to @parameters
		  		i+=1
		  	end


	      paramnum = @matrix_config.matrix_params.count
	      allresults = Array.new
	      resultnum = 0
	      
		@matrix_config.results.each do  |result|

				allresults << result
				resultnum+=1

		end
		
	      puts "true results num ="
	      puts resultnum

		j = 0
		recordsArr = Array.new
	    while j <resultnum do
		record = Record.new
		paramindex=0
			while paramindex<paramnum do
			result = allresults[j]
			elementindex=0
				while elementindex < @manager.parameters.paramsArr[paramindex].elementsArr.length do
					if @manager.parameters.paramsArr[paramindex].elementsArr[elementindex].value ==result.value_id
					break
					end
					elementindex+=1
				end
			record.valuesArr[paramindex]=result.value_id
			paramindex+=1
			j+=1
			end
		
		 @manager.records.recordsArr << record
	end
		@allArray = Array.new @manager.records.recordsArr.length
		@sarray = Array.new
		@stotal = 0
		@tarray = Array.new
		@ttotal = 0		
		i = 0
		while i < @manager.records.recordsArr.length do 
                                temweight = -1
				tem = Array.new 
                      if params[:tag]=="hasid" #add by ycy
				if @manager.records.recordsArr[i].valuesArr[@selectedparameterindex].to_i == @selectedvalue_id.to_i #include special value

					@matrix_config.matrix_params.each do |matrix_param|
						matrix_param.matrix_values.each do |matrix_value|
							if matrix_value.value_id ==@manager.records.recordsArr[i].valuesArr[@selectedparameterindex]
								temweight = matrix_value.weight
								break
							end
						end
					end
				
				@allArray[i]=[i,temweight.to_i,0]



				@sarray << i
				@stotal+=temweight.to_i

				else

					j =0
					while j < @manager.records.recordsArr[i].valuesArr.length do
				#temweight += @matrix_config.matrix_params.matrix_values.find_by_value_id(@manager.records.recordsArr[i].valuesArr[j]).weight
				@matrix_config.matrix_params.each do |matrix_param|
							matrix_param.matrix_values.each do |matrix_value|
								if matrix_value.value_id ==@manager.records.recordsArr[i].valuesArr[j]
									temweight += matrix_value.weight
									break
								end
							end
						end

						
						j+=1
					end
					@allArray[i]=[i,temweight.to_i,0]

					@tarray << i
					@ttotal += temweight
				end
                        else #add by ycy-------------------------start
                             j =0
					while j < @manager.records.recordsArr[i].valuesArr.length do
				#temweight += @matrix_config.matrix_params.matrix_values.find_by_value_id(@manager.records.recordsArr[i].valuesArr[j]).weight
				@matrix_config.matrix_params.each do |matrix_param|
							matrix_param.matrix_values.each do |matrix_value|
								if matrix_value.value_id ==@manager.records.recordsArr[i].valuesArr[j]
									temweight += matrix_value.weight
									break
								end
							end
						end

						
						j+=1
					end
					@allArray[i]=[i,temweight.to_i,0]

					@tarray << i
					@ttotal += temweight
                        end #add by ycy-------------------------end


				i+=1
			end
		 if params[:tag]=="hasid" #add by ycy----------------			

		     if @sbili.to_i > @sarray.length*100 
			@sbili = @sarray.length*100
		     end

			
		     s = @sbili.to_f/@stotal
		    
		     i = 0
		     while i < @sarray.length do
			@allArray[@sarray[i]][2]=@allArray[@sarray[i]][1]*s

			i+=1
		     end
		      if (@tbili.to_f-@sbili.to_f)<0
			@tbili=@tarray.length*100
		      end
		     s = (@tbili.to_f-@sbili.to_f)/@ttotal.to_f
		     i = 0
		     while i < @tarray.length do
			@allArray[@tarray[i]][2]=@allArray[@tarray[i]][1]*s

			i+=1
		    end
              end #add by ycy------------------------

	puts "selectedparameterindex"
	puts @selectedparameterindex
      

	endtime = Time.now
	@costtime = endtime - starttime



  end

	
end
