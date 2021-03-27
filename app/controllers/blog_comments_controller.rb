class BlogCommentsController < ApplicationController

  def create
    @blog = Blog.find(params[:blog_id])
    comment = current_user.blog_comments.new(blog_comment_params)
    comment.blog_id = @blog.id
    unless comment.save
      render 'error'
      # error.js.erbを参照
    end
    # create.js.erbを参照
  end

  def destroy
    @blog = Blog.find(params[:blog_id])
    blog_comment = @blog.blog_comments.find(params[:id]).destroy
    # destroy.js.erbを参照
  end

  private

  def blog_comment_params
    params.require( :blog_comment).permit(:comment)
  end


end
