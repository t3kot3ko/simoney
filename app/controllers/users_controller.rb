class UsersController < ApplicationController
	before_action :authenticate_user!, except: []
  before_action :set_user

  # GET /users/1
  # GET /users/1.json
  def show
  end

	def __transition(user, s_date, e_date)
		history = user.property_fix_histories.where("fixed_date >= ? and fixed_date <= ?", s_date, e_date).group_by(&:fixed_date)

		plans = user.planned(s_date, e_date)
		regular_plans = user.regular_planned(s_date, e_date)

		transition = {}
		property = nil
		(s_date .. e_date).each do |date|
			if history[date] && (h = history[date].first)
				property = h.new_property
			end

			if property
				sum_income = 0
				sum_expense = 0

				if ps = plans[date]
					ps.each do |e|
						if (amount = e.amount) > 0
							sum_income += amount
						else
							sum_expense += amount
						end
					end
				end

				if rps = regular_plans[date]
					rps.each do |e|
						if (amount = e.amount) > 0
							sum_income += amount
						else
							sum_expense += amount
						end
					end
				end

				property += (sum_income + sum_expense)
				transition[date] = [property, sum_income, sum_expense]
			else
				transition[date] = nil
			end
		end

		return transition
	end

	def dashboard
		today = Date.today
		@s_date = today - (today.day - 1)
		@e_date = @s_date + 1.month - 1
		@history = current_user.property_fix_histories.where("fixed_date >= ? and fixed_date <= ?", @s_date, @e_date).group_by(&:fixed_date)

		# TODO: duplicated!
		@plans = current_user.planned(@s_date, @e_date)
		@regular_plans = current_user.regular_planned(@s_date, @e_date)

		@balance_transition = __transition(current_user, @s_date, @e_date)

		dates = @balance_transition.map{|key, value| key if value}.compact
		data = dates.map{|date| @balance_transition[date].first}
		categories = dates.map{|e| e.strftime "%d"}

		@monthly_sum_income = 0
		@monthly_sum_expense = 0

		@balance_transition.each do |key, value|
			_, income, expense = *value
			@monthly_sum_income += (income || 0)
			@monthly_sum_expense += (expense|| 0)
		end

		@expected_balance = @balance_transition[@e_date].first

		@graph = LazyHighCharts::HighChart.new("graph") do |f|
			f.xAxis(categories: categories)
			f.series(name: "残高", yAxis: 0, data: data)
		end
	end

	def list
		@all_plans = current_user.plans.order(:planned_at).after_today.group_by(&:planned_at)
		@property = current_user.property
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
		new_property = user_params[:property]
		if @user.fix_property(new_property)
			redirect_to dashboard_user_path, notice: 'User was successfully updated.'
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

	def histories
		render text: current_user.property_fix_histories.inspect and return
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
