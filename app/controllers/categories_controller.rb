class CategoriesController < ApplicationController
  
  before_action :authenticate, except: [:index, :show]

  respond_to :json

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      render json: @category.to_json, status: :created 
    else
      render json: @category.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
    
  end

  def update
    
  end

  def destroy
    
  end

  private

    def category_params
      params.require(:category).permit(:title)
    end
end
