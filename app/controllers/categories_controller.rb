class CategoriesController < ApplicationController
	before_action :authenticate_user!
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  # GET /categories.json
  def index
		@categories = current_user.categories
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)
		@category.user = current_user

    respond_to do |format|
      if @category.save
        format.html { redirect_to user_categories_path, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to user_categories_path, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
		# Category can be deleted ONLY WHEN no plans/regular_plans belong to the category
		category_id = params[:id]
		if current_user.plans.exists?(category_id: category_id) || current_user.regular_plans.exists?(category_id: category_id)
			redirect_to user_categories_path, alert: "There are plans or regular plans belonging to this category" and return
		end

    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
			@category = current_user.categories.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
			params.require(:category).permit(:name)
    end
end
