class FavoritesController < ApplicationController
	# いいね機能も、indexアクションやnewアクションは作成しません。
	# コメント機能同様、投稿画像の詳細画面（/post_image/:id/）で実装します。
		def create
            post_image = PostImage.find(params[:post_image_id])
            favorite = current_user.favorites.new(post_image_id: post_image.id)# 省略形
            favorite.save
            redirect_to post_image_path(post_image)
        end
        def destroy
            post_image = PostImage.find(params[:post_image_id])
            favorite = current_user.favorites.find_by(post_image_id: post_image.id)# 省略形
            favorite.destroy
            redirect_to post_image_path(post_image)
        end
end
