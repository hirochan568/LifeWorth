class SearchController < ApplicationController
  before_action :authenticate_user!

	def search
		@model = params[:model]
		@content = params[:content]
		@method = params[:method]
		if @model == 'blog'
			@records = Blog.search_for(@content, @method)
			
		elsif @model == 'review'
			@records = Review.search_for(@content, @method)
			
		elsif @model == 'question'
			@records = Question.search_for(@content, @method)
		end
		
		
	end
	
end
