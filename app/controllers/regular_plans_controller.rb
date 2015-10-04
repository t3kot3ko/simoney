class RegularPlansController < ApplicationController
  before_action :set_regular_plan, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!
	before_action :set_selector_options, only: [:new, :edit]
	before_action :set_kind_selector_options, only: [:new, :edit]

	def set_selector_options
		@selector_options = []
		current_user.categories.each do |category|
			@selector_options << [category.name, category.id]
		end
	end

	# TODO: extract to model or helper
	def set_kind_selector_options
		@kind_selector_options = []
		dict = {
			"daily" => "毎日",
			"weekly" => "毎週",
			"monthly" => "毎月",
			"yearly" => "毎年",
		}

		RegularPlan.kinds.each do |key, value|
			@kind_selector_options << [dict[key], key]
		end
	end

  # GET /regular_plans
  # GET /regular_plans.json
  def index
		f = params[:filter]
		regular_plans = current_user.regular_plans

		case f 
		when "income"
			@regular_plans = regular_plans.where("amount > 0")
			@filter = "income"
		when "expense"
			@regular_plans = regular_plans.where("amount < 0")
			@filter = "expense"
		else 
			@regular_plans = regular_plans
			@filter = "all"
		end
	end

  # GET /regular_plans/1
  # GET /regular_plans/1.json
  def show
  end

  # GET /regular_plans/new
  def new
    @regular_plan = RegularPlan.new
  end

  # GET /regular_plans/1/edit
  def edit
  end

  # POST /regular_plans
  # POST /regular_plans.json
  def create
    @regular_plan = RegularPlan.new(regular_plan_params)
		@regular_plan.user = current_user

    respond_to do |format|
      if @regular_plan.save
        format.html { redirect_to user_regular_plans_path, notice: 'Regular plan was successfully created.' }
        format.json { render :show, status: :created, location: @regular_plan }
      else
        format.html { render :new }
        format.json { render json: @regular_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /regular_plans/1
  # PATCH/PUT /regular_plans/1.json
  def update
    respond_to do |format|
      if @regular_plan.update(regular_plan_params)
        format.html { redirect_to user_regular_plans_path, notice: 'Regular plan was successfully updated.' }
        format.json { render :show, status: :ok, location: @regular_plan }
      else
        format.html { render :edit }
        format.json { render json: @regular_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /regular_plans/1
  # DELETE /regular_plans/1.json
  def destroy
    @regular_plan.destroy
    respond_to do |format|
      format.html { redirect_to regular_plans_url, notice: 'Regular plan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_regular_plan
      @regular_plan = RegularPlan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def regular_plan_params
      params.require(:regular_plan).permit(:category_id, :amount, :start_date, :kind)
    end
end
