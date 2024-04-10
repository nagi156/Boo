class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    following = current_user.relationships.build(follower_id: params[:user_id])
    following.save
    redirect_to request.referer
  end

  def destroy
    following = current_user.relationships.find_by(follower_id: params[:user_id])
    following.destroy
    redirect_to request.referer
  end
  # フォロー/フォロワーの一覧のためのメソッド
  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end

end
