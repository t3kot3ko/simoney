class UsersController < ApplicationController
	before_action :authenticate_user!
  before_action :set_user

  # GET /users/1
  # GET /users/1.json
  def show
  end

	def dashboard
		today = Date.today
		e_date = (today - (today.day - 1)) + 1.month

		monthly_transition = @user.monthly_transition(today, e_date)
		categories = monthly_transition.map{|e| e.first.to_s}
		data = monthly_transition.map{|e| e.last}

		@graph = LazyHighCharts::HighChart.new("graph") do |f|
			f.title(text: "Monthly transition")
			f.xAxis(categories: categories)
			f.series(name: "remain", yAxis: 0, data: data)
		end
	end

	def history
		@history = @user
	end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end


  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
		render text: params and return

		new_property = user_params[:property]
		if @user.fix_property(new_property)
			redirect_to dashboard_user_path(@user), notice: 'User was successfully updated.'
		else
			render :edit
		end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
			params[:user]
    end
end
