class MatrixConfigsController < ApplicationController
  # GET /matrix_configs
  # GET /matrix_configs.json
  def index

    @group = Group.find(params[:group_id])
    @matrix_configs = @group.matrix_configs
    
 
    #@matrix_configs = MatrixConfig.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @matrix_configs }
    end
  end

  # GET /matrix_configs/1
  # GET /matrix_configs/1.json
  def show
    @matrix_config = MatrixConfig.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @matrix_config }
    end
  end

  # GET /matrix_configs/new
  # GET /matrix_configs/new.json
  def new
    @group = Group.find(params[:group_id])
    @matrix_config = @group.matrix_configs.new

    @matrix_config.has_results = 0

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @matrix_config }
    end
  end

  # GET /matrix_configs/1/edit
  def edit
    @matrix_config = MatrixConfig.find(params[:id])
  end

  # POST /matrix_configs
  # POST /matrix_configs.json
  def create
    @matrix_config = MatrixConfig.new(params[:matrix_config])
    @matrix_config.has_results =0
    respond_to do |format|
      if @matrix_config.save
        format.html { redirect_to @matrix_config, notice: 'Matrix config was successfully created.' }
       # format.json { render json: @matrix_config, status: :created, location: @matrix_config }
#format.json { render :json=>{'statusCode'=>'200','message'=>'Add Matrix Success!','navTableId'=>'','rel'=>'','callbackType'=>'closeCurrent','forwardUrl'=>'','confirmMsg'=>''} }
format.json { render :json=>{'statusCode'=>'200','message'=>'Add Matrix Success!','navTableId'=>'sidetab','rel'=>'',
'callbackType'=>'closeCurrent','forwardUrl'=>"/groups/sidebartab?user_id=#{params[:user_id]}",'confirmMsg'=>''} }
      else
        format.html { render action: "new" }
        format.json { render json: @matrix_config.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /matrix_configs/1
  # PUT /matrix_configs/1.json
  def update
    @matrix_config = MatrixConfig.find(params[:id])

    respond_to do |format|
      if @matrix_config.update_attributes(params[:matrix_config])
        format.html { redirect_to @matrix_config, notice: 'Matrix config was successfully updated.' }
        #format.json { head :no_content }
format.json { render :json=>{'statusCode'=>'200','message'=>'Edit Matrix Success!','navTableId'=>'','rel'=>'','callbackType'=>'','forwardUrl'=>'','confirmMsg'=>''} }
      else
        format.html { render action: "edit" }
        format.json { render json: @matrix_config.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /matrix_configs/1
  # DELETE /matrix_configs/1.json
  def destroy
    @matrix_config = MatrixConfig.find(params[:id])
    @user = User.find(Group.find(@matrix_config.group_id).user_id)
    @matrix_config.destroy
	
    respond_to do |format|
# format.html { redirect_to groups_url(:user_id=>@user_id) }

      #format.html { redirect_to matrix_configs_url(:group_id=>@matrix_config.group_id) }
      format.html { redirect_to groups_url(:user_id=>@user) }
      format.json { head :no_content }
    end
  end
end
