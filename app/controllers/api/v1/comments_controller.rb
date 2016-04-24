class Api::V1::CommentsController < ApplicationController
	skip_before_filter  :verify_authenticity_token
	skip_before_action  :verify_authenticity_token
	respond_to :json
	before_action :restrict_access
	before_action :find_clip
	before_action :find_comment, only: [:update, :destroy]
	before_action :get_current_user, only: [:create]

	def create
		@comment = Comment.new(comment_params)
		@comment.clip_id = @clip.id
		@comment.user_id = @current_rest_user.id
		if @comment.save
			render :json => {:message => "comment created", :comment => @comment}
		else
			render :json => {:message => "comment error", :errors => @comment.errors}
		end
	end
 	
	def update
	end

	def destroy
	end

	private
	def comment_params
		params.require(:comment).permit(:title, :body)
	end

	def find_clip
		@clip = Clip.find(params[:clip_id])
	end

	def find_comment
	end

	######
	def restrict_access
		authenticate_or_request_with_http_token do |token, options|
			return true if (token == "test")
		end
	end

	def get_current_user
		@current_rest_user = User.find(request.headers["user"])
	end

end