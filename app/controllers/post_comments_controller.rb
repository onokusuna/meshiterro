class PostCommentsController < ApplicationController
	# 今回、indexアクションやnewアクションは作成しません。
	# つまり、コメント投稿だけの一覧画面や投稿画面は作成せず、その代わり、投稿画像の詳細画面（/post_image/:id/）にコメント投稿機能を実装します。
	def create
	end
	def show # 2 詳細
		
	end
	def create # 5 保存 コメント投稿機能を作成する
		post_image = PostImage.find(params[:post_image_id])
		# comment = PostComment.new(post_comment_params)<br>comment.user_id = current_user.idの省略記述
	    comment = current_user.post_comments.new(post_comment_params)# 現在のuserがコメントすると初期値のコメントが作られその中に引数（投稿した内容）が反映され、それがcommentと定義されている？
	    comment.post_image_id = post_image.id# comment.post_image_id(コメントのid) と post_image.id(ユーザーのid)が一致していたらsave
	    comment.save
	    redirect_to post_image_path(post_image)# post_images#show
	end
	private
	def post_comment_params
	    params.require(:post_comment).permit(:comment)
	end
end
