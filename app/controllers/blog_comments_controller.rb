class BlogCommentsController < ApplicationController

  def create
    blog = Blog.find(params[:blog_id])
    comment = current_user.blog_comments.new(blog_comment_params)
    comment.blog_id = blog.id
    comment.save
    redirect_to blog_details_path(blog)
  end

  def destroy
    @blog = Blog.find(params[:blog_id])
    blog_comment = @blog.blog_comments.find(params[:id]).destroy
    redirect_to blog_details_path(@blog)
  end

  private

  def blog_comment_params
    params.require( :blog_comment).permit(:comment)
  end


end
