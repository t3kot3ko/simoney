class RegularPlansController < ApplicationController
  before_action :set_regular_plan, only: [:show, :edit, :update, :destroy]

  # GET /regular_plans
  # GET /regular_plans.json
  def index
    @regular_plans = RegularPlan.all
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

    respond_to do |format|
      if @regular_plan.save
        format.html { redirect_to @regular_plan, notice: 'Regular plan was successfully created.' }
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
        format.html { redirect_to @regular_plan, notice: 'Regular plan was successfully updated.' }
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
      params.require(:regular_plan).permit(:user_id, :category, :amount, :start_date, :interval)
    end
end