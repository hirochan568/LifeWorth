class BlogsController < ApplicationController

  
  def index
    @blogs = Blog.all
  end

  def show
    @blog = Blog.find(params[:id])
  end
  
  def create
  end


  def destroy
  end
  
  private

  def customer_params
    params.require(:blog).permit(:name, :body, :image, :category)
  end
  
end
