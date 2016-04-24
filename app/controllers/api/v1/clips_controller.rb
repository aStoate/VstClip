class Api::V1::ClipsController < ApplicationController
	skip_before_filter  :verify_authenticity_token
	respond_to :json
	before_action :restrict_access
	before_action :find_clip, only: [:show, :update, :destroy, :like_clip, :unlike_clip]
	before_action :get_current_user, only: [:create, :like_clip, :unlike_clip]

	def index
		respond_with Clip.all
	end

	def show
		respond_with @clip
	end

	def create
		@clip = @current_rest_user.clips.build(clip_params)
		if @clip.save
			render :json => {:message => "created"}
		else
			render :json => {:message => "Error", :errors => @clip.errors}
		end
	end

	def update
	end

	def destroy
		@clip.comments.each do |c|
			c.destroy
		end
		@clip.destroy
		render :json => {:message => "Clip Destroyed"}
	end

	def like_clip
		@clip.like_count +=1
		@current_rest_user.like!(@clip)
		@clip.save
		render :json => {:message => "Clip Liked"}
	end

	def unlike_clip
		@clip.like_count -=1
		@current_rest_user.unlike!(@clip)
		@clip.save
		render :json =>{:message => "Clip Unliked"}
	end

private
	def get_current_user
		@current_rest_user = User.find(request.headers["user"])
	end

	def restrict_access
		authenticate_or_request_with_http_token do |token, options|
			return true if (token == "test")
		end
	end

	def clip_params
		params.require(:clip).permit(:title, :description, :url)
	end

	def find_clip
		@clip = Clip.find(params[:id])
	end

end
