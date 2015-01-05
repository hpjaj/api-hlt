class Categories::PostsController < ApplicationController

  before_action :authenticate, except: [:show]

  respond_to :json

  def new
    @category = Category.find(params[:category_id])
    @post = Post.new
  end

  def create
    @category = Category.find(params[:category_id])
    @post = current_user.posts.build(post_params)
    @post.category = @category
    if @post.save
      render json: @post.to_json, status: :created 
    else
      render json: @post.errors.full_messages, status: :unprocessable_entity 
    end
  end

  def show
    @category = Category.find(params[:category_id])
    @post = Post.find(params[:id])
  end

  def edit
    
  end

  def update
    
  end

  def destroy
    
  end

  private

    def post_params
      params.require(:post).permit(:title, :body, :category_id, :user_id)
    end

end
