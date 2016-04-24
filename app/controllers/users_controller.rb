class UsersController < ApplicationController
before_action :find_user, only: [:show, :edit, :update, :destroy, :follow_user, :unfollow_user]


  def index
    @users = User.all
  end


  def show
  end

  def follow_user
  	@user.follow_count += 1
  	@user.save
  	current_user.follow!(@user)
  	render 'show'
  end

  def unfollow_user
	@user.follow_count -= 1
  	@user.save
  	current_user.unfollow!(@user) 
  	render 'show'
  end

  private

	def find_user
		@user = User.find(params[:id])
	end

end