class CommentsController < ApplicationController
  before_action :find_comment
  
	def mark_as_not_abusive
		@comment.mark_as_not_abusive
		render "posts/show"
	end

	def vote_up
		@comment.vote_up(current_user.id)
    render "posts/show"
	end
  
  private
	def find_comment
		@comment = Comment.find(params[:id])
	end
end
