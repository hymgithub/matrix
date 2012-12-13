class LimitPairsController < ApplicationController
  # GET /limit_pairs
  # GET /limit_pairs.json
  def index
    @limit_pairs = LimitPair.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @limit_pairs }
    end
  end

  # GET /limit_pairs/1
  # GET /limit_pairs/1.json
  def show
    @limit_pair = LimitPair.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @limit_pair }
    end
  end

  # GET /limit_pairs/new
  # GET /limit_pairs/new.json
  def new
    @matrix_config = MatrixConfig.find(params[:matrix_config_id])
    frist_value_id = params[:first_value_id]
    second_value_id = params[:second_value_id]
    @matrix_params = @matrix_config.matrix_params
    @limit_pair = @matrix_config.limit_pairs.new
    @limit_pair.first_value_id = params[:first_value_id]
    @limit_pair.second_value_id = params[:second_value_id]

#    @limit_pair = LimitPair.new

    respond_to do |format|
      format.html  #new.html.erb
      format.json { render json: @limit_pair }
    end
  end

  # GET /limit_pairs/1/edit
  def edit
    @limit_pair = LimitPair.find(params[:id])
  end

  # POST /limit_pairs
  # POST /limit_pairs.json
  def create
    @limit_pair = LimitPair.new(params[:limit_pair])

    respond_to do |format|
      if @limit_pair.save
        #format.html { redirect_to @limit_pair, notice: 'Limit pair was successfully created.' }
 #format.html { redirect_to :action=>'index',:matrix_config_id=>@limit_pair.matrix_config_id}
format.html { redirect_to matrix_params_path(:matrix_config_id=>@limit_pair.matrix_config_id)}
       # format.json { render json: @limit_pair, status: :created, location: @limit_pair }
format.json { render :json=>{'statusCode'=>'200','message'=>'Edit Group Success!','navTableId'=>'','rel'=>'','callbackType'=>'','forwardUrl'=>'','confirmMsg'=>''} }
      else
#        format.html { render action: "new" }
        format.json { render json: @limit_pair.errors, status: :unprocessable_entity }
      end
    end
  end

=begin
  def getSecondValue
	@matrix_config = MatrixConfig.find(:all)
        @matrix_params.each do |matrix_param|
             matrix_param.matrix_values.each do |matrix_value|
		@matrix_values<<matrix_value
	     end
	end

  end
=end 

  # PUT /limit_pairs/1
  # PUT /limit_pairs/1.json
  def update
    @limit_pair = LimitPair.find(params[:id])

    respond_to do |format|
      if @limit_pair.update_attributes(params[:limit_pair])
        format.html { redirect_to @limit_pair, notice: 'Limit pair was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @limit_pair.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /limit_pairs/1
  # DELETE /limit_pairs/1.json
  def destroy
    @limit_pair = LimitPair.find(params[:pair_id])
    @matrix_config_id = @limit_pair.matrix_config_id
    @limit_pair.destroy

    respond_to do |format|
      format.html { redirect_to :controller=>"matrix_params", :action=>'index',:matrix_config_id=>@matrix_config_id }
      format.json { render :json=>{'statusCode'=>'200','message'=>'Delete Success!','navTabID'=>'','rel'=>'','callbackType'=>'closeCurrent','forwardUrl'=>''} }
      #format.html { redirect_to limit_pairs_url }
      #format.json { head :no_content }
      #format.json { render :json=>{'statusCode'=>'200','message'=>'Delete Success!','navTabID'=>'','rel'=>'','forwardUrl'=>''} }
      #format.json{render :json=>{ 'statusCode' =>'200', 'message'=>'Add records succeed!','navTabID' => '', 'rel' =>'','config_id'=> $matrix_config.id,'url'=>"/matrix_params/index" }}
    end
  end

  def del
      logger.info("~~~~~~~~~")
      @limit_pair = LimitPair.find(params[:id])
  end

end
