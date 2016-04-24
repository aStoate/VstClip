class CommentsController < ApplicationController
	before_action :find_clip
	before_action :find_comment, only: [:edit, :update, :destroy]

	def new
		@comment = Comment.new
	end

	def create
		@comment = Comment.create(comment_params)
		@comment.clip_id = @clip.id
		@comment.user_id = current_user.id
		if @comment.save
			redirect_to clip_path(@clip)
		else
			render'new'
		end		
	end

	def edit
	end

	def update
		if @comment.update(comment_params)
			redirect_to clip_path(@clip)
		else
			render 'edit'
		end
	end

	def destroy
		@comment.destroy
		redirect_to clip_path(@clip)
	end

	private
	def comment_params
		params.require(:comment).permit(:title, :body)
	end

	def find_clip
		@clip = Clip.find(params[:clip_id])
	end

	def find_comment
		@comment = Comment.find(params[:id])
	end
end
