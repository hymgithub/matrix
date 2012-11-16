class ValuesController < ApplicationController
  # GET /values
  # GET /values.json

  def index
    @parameter = Parameter.find(params[:parameter_id])
    @values = @parameter.values

      respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @values }
    end
  end


   def abc
    @parameter = Parameter.find(params[:parameter_id])
    @values = @parameter.values


#     @values = Value.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @values }
    end
  end



  # GET /values/1
  # GET /values/1.json
  def show
    
    @value = Value.find(params[:id])
    if @value==nil
     puts "@value=nil"
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @value }
    end
  end

  # GET /values/new
  # GET /values/new.json
  def new  

    @parameter = Parameter.find(params[:parameter_id])
    @values = @parameter.values.new
   	
#   @value = Value.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @value }
    end
  end

  # GET /values/1/edit
  def edit
   
    @value = Value.find(params[:id])
    @parameter = @value.parameter
    
  end

  # POST /values
  # POST /values.json
  def create
    @parameter = Parameter.find(params[:parameter_id])
    @value = @parameter.values.create(params[:value])

#    @value = Value.new(params[:value])

    respond_to do |format|
      if @value.save
        format.html { redirect_to @parameter, notice: 'Value was successfully created.' }
        format.json { render json: @value, status: :created, location: @value }
      else
        format.html { render action: "new" }
        format.json { render json: @value.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /values/1
  # PUT /values/1.json
  def update
    @value = Value.find(params[:id])

    respond_to do |format|
      if @value.update_attributes(params[:value])
        format.html { redirect_to @value, notice: 'Value was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @value.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /values/1
  # DELETE /values/1.json
  def destroy
    @value = Value.find(params[:id])
    @value.destroy
    @parmater=@value.parameter

    respond_to do |format|
      format.html { redirect_to :action=>'index',:parameter_id=>@value.parameter_id }
      format.json { head :no_content }
    end
  end
end
