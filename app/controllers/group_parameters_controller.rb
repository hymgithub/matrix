class GroupParametersController < ApplicationController
  # GET /group_parameters
  # GET /group_parameters.json
  def index
    @group_parameters = GroupParameter.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @group_parameters }
    end
  end

  # GET /group_parameters/1
  # GET /group_parameters/1.json
  def show
    @group_parameter = GroupParameter.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group_parameter }
    end
  end

  # GET /group_parameters/new
  # GET /group_parameters/new.json
  def new
    @group_parameter = GroupParameter.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @group_parameter }
    end
  end

  # GET /group_parameters/1/edit
  def edit
    @group_parameter = GroupParameter.find(params[:id])
  end

  # POST /group_parameters
  # POST /group_parameters.json
  def create

#  @group_parameter = GroupParameter.new(params[:group_parameter])
	
    @group = Group.find(params[:group_id])

    parameter = Parameter.find(params[:parameter_id])

    @group.group_parameters.build(:parameter=>parameter)

    respond_to do |format|
      if @group_parameter.save
        format.html { redirect_to @group_parameter, notice: 'Group parameter was successfully created.' }
        format.json { render json: @group_parameter, status: :created, location: @group_parameter }
      else
        format.html { render action: "new" }
        format.json { render json: @group_parameter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /group_parameters/1
  # PUT /group_parameters/1.json
  def update
    @group_parameter = GroupParameter.find(params[:id])

    respond_to do |format|
      if @group_parameter.update_attributes(params[:group_parameter])
        format.html { redirect_to @group_parameter, notice: 'Group parameter was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @group_parameter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_parameters/1
  # DELETE /group_parameters/1.json
  def destroy
    @group_parameter = GroupParameter.find(params[:id])
    @group_parameter.destroy

    respond_to do |format|
      format.html { redirect_to group_parameters_url }
      format.json { head :no_content }
    end
  end
end
