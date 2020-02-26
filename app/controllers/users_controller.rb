class UsersController < ApplicationController
  def show# マイページ作成
  	@user = User.find(params[:id])
    @post_images = @user.post_images.page(params[:page]).reverse_order  # そのユーザ（@user）に関連付けられた投稿（.post_images）のみ、@post_imagesに渡すことができます。late順
  end
  # プロフィール編集用
  def edit
    @user = User.find(params[:id])# params[:id]でユーザの情報を取得してインスタンス（@user）に保存し、編集用Viewでform_forを使う準備をしています。
  end

  def update # 6 更新
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  private
  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
end
