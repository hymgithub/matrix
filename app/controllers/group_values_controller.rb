class GroupValuesController < ApplicationController
  # GET /group_values
  # GET /group_values.json
  def index
    @group_values = GroupValue.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @group_values }
    end
  end

  # GET /group_values/1
  # GET /group_values/1.json
  def show
    @group_value = GroupValue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @group_value }
    end
  end

  # GET /group_values/new
  # GET /group_values/new.json
  def new
    @group_value = GroupValue.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @group_value }
    end
  end

  # GET /group_values/1/edit
  def edit
    @group_value = GroupValue.find(params[:id])
  end

  # POST /group_values
  # POST /group_values.json
  def create
    @group_value = GroupValue.new(params[:group_value])

    respond_to do |format|
      if @group_value.save
        format.html { redirect_to @group_value, notice: 'Group value was successfully created.' }
        format.json { render json: @group_value, status: :created, location: @group_value }
      else
        format.html { render action: "new" }
        format.json { render json: @group_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /group_values/1
  # PUT /group_values/1.json
  def update
    @group_value = GroupValue.find(params[:id])

    respond_to do |format|
      if @group_value.update_attributes(params[:group_value])
        format.html { redirect_to @group_value, notice: 'Group value was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @group_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_values/1
  # DELETE /group_values/1.json
  def destroy
    @group_value = GroupValue.find(params[:id])
    @group_value.destroy

    respond_to do |format|
      format.html { redirect_to group_values_url }
      format.json { head :no_content }
    end
  end
end
