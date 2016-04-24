class Api::V1::UsersController < ApplicationController
	skip_before_filter :verify_authenticity_token
	respond_to :json
	before_action :restrict_access
	before_action :find_user, only: [:show, :update, :destroy, :follow_user, :unfollow_user]
	before_action :get_current_user, only:[:follow_user, :unfollow_user]

	def index
		respond_with User.all
	end

	def show
		respond_with @user
	end

	def follow_user
		@user.follow_count += 1
		@current_rest_user.follow!(@user)
		@user.save
		render :json => {:message => "#{@current_rest_user.id} now following #{@user.id}"}
	end

	def unfollow_user
		@user.follow_count -= 1
		@current_rest_user.unfollow!(@user)
		@user.save
		render :json => {:message => "unfollowed"}
	end

	private

	def restrict_access
		authenticate_or_request_with_http_token do |token, options|
			return true if (token == "test")
		end
	end

	def find_user
		@user = User.find(params[:id])
	end

	def get_current_user
		@current_rest_user = User.find(request.headers["user"])
	end
end
