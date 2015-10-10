class PlansController < ApplicationController
	before_action :authenticate_user!
  before_action :set_plan, only: [:show, :edit, :update, :destroy]
	before_action :set_selector_options, only: [:new, :edit]

	def set_selector_options
		@selector_options = []
		current_user.categories.each do |category|
			@selector_options << [category.name, category.id]
		end
	end

  # GET /plans
  # GET /plans.json
  def index
		plans = current_user.plans.order(:planned_at).after_today

		case params[:filter]
		when "income"
			@plans = plans.where("amount > 0")
			@filter = "income"
		when "expense"
			@plans = plans.where("amount < 0")
			@filter = "expense"
		else 
			@plans = plans
			@filter = "all"
		end
  end

  # GET /plans/1
  # GET /plans/1.json
  def show
  end

  # GET /plans/new
  def new
    @plan = Plan.new
  end

  # GET /plans/1/edit
  def edit
  end

  def create
    @plan = Plan.new(plan_params)
		@plan.user = current_user

    respond_to do |format|
      if @plan.save
        format.html { redirect_to user_plans_path, notice: 'Regular plan was successfully created.' }
        format.json { render :show, status: :created, location: @regular_plan }
      else
        format.html { render :new }
        format.json { render json: @regular_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plans/1
  # PATCH/PUT /plans/1.json
  def update
    respond_to do |format|
      if @plan.update(plan_params)
				format.html { redirect_to user_plans_path, notice: 'Plan was successfully updated.' }
        format.json { render :show, status: :ok, location: @plan }
      else
        format.html { render :edit }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plans/1
  # DELETE /plans/1.json
  def destroy
    @plan.destroy
    respond_to do |format|
      format.html { redirect_to user_plans_url, notice: 'Plan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan
      @plan = Plan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plan_params
			params[:plan].permit(:category_id, :description, :amount, :planned_at)
    end
end
