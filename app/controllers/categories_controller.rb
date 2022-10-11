class CategoriesController < ApplicationController
  before_action :require_admin_user, only: [:edit, :update, :destroy, :create, :new]
  before_action :find_id, only: [:show, :edit, :update, :destroy]

  def index
    @pagy , @categories = pagy(Category.all, items: 4)
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(set_params)
    if @category.save
      redirect_to categories_path, :notice => "Category was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @category.update(set_params)
      redirect_to categories_path, :notice=>"Category was successfully updated."
    else
      render :edit
    end
  end

  def destroy 
    @category.destroy
    redirect_to categories_path, :notice => "Categories was successfully deleted."
  end

  private

  def find_id
    @category = Category.find(params[:id])
  end
  
  def set_params
    params.require(:category).permit(:name)
  end

  def require_admin_user
    if !current_user.admin?
      redirect_to categories_path, :notice => "You Not Allowed To Create Category"
    end
  end
end