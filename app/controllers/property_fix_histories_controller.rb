class PropertyFixHistoriesController < ApplicationController
	before_action :authenticate_user!
  before_action :set_property_fix_history, only: [:show, :edit, :update, :destroy]

  # GET /property_fix_histories
  # GET /property_fix_histories.json
  def index
		@property_fix_histories = current_user.property_fix_histories
  end

  # GET /property_fix_histories/new
  def new
    @property_fix_history = PropertyFixHistory.new
  end

  # GET /property_fix_histories/1/edit
  def edit
  end

  # POST /property_fix_histories
  # POST /property_fix_histories.json
  def create
		new_property = property_fix_history_params[:new_property]
		fixed_date = property_fix_history_params[:fixed_date]

		result = current_user.fix_property(new_property, fixed_date)

    respond_to do |format|
      if result
        format.html { redirect_to user_histories_path, notice: 'Property fix history was successfully created.' }
        format.json { render :show, status: :created, location: @property_fix_history }
      else
        format.html { render :new }
        format.json { render json: @property_fix_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /property_fix_histories/1
  # PATCH/PUT /property_fix_histories/1.json
  def update
    respond_to do |format|
      if @property_fix_history.update(property_fix_history_params)
        format.html { redirect_to user_histories_path, notice: 'Property fix history was successfully updated.' }
        format.json { render :show, status: :ok, location: @property_fix_history }
      else
        format.html { render :edit }
        format.json { render json: @property_fix_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /property_fix_histories/1
  # DELETE /property_fix_histories/1.json
  def destroy
    @property_fix_history.destroy
    respond_to do |format|
      format.html { redirect_to property_fix_histories_url, notice: 'Property fix history was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_property_fix_history
      @property_fix_history = PropertyFixHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def property_fix_history_params
			params.require(:property_fix_history).permit(:new_property, :fixed_date)
    end
end
