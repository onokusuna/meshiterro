class PostImagesController < ApplicationController
# 画像の投稿画面を表示する
	def new
		@post_image = PostImage.new# 1.空のインスタンスを渡して、画像の投稿ができるようにします。
    end
# 投稿画像を保存する
    def create
    	# 9,10行目統合可能has manyのおかげ=>@post_image = PostImage.current_user.id.new(post_image_params)???わからん省略系の記述の方がメジャー
    	@post_image = PostImage.new(post_image_params)# 2.投稿データを保存する。投稿データを保存するには、Strong Parametersも必要なので、同時に定義
    	@post_image.user_id = current_user.id# current=現在の @post_image.user.idは現在のuser.idと一致した場合save
    	if @post_image.save
          redirect_to post_images_path# saveメソッドの結果がtrueならば、images#indexにリダイレクトさせます。
        else
          render :new# 画像投稿ページを再表示するように設定します。post_images#new
        end
    end
# 投稿画像のリストを表示する画面を作る
    def index# reverse_order=降順に取得したい場合
    	@post_images = PostImage.page(params[:page]).reverse_order# 3.postimagesテーブル内の全データが取得されていました。これを、1ページ分の決められた数のデータだけを、新しい順に取得するように変更しています。
    end
# 投稿画像の詳細を表示する画面を作る
    def show
    	@post_image = PostImage.find(params[:id])# idを持った@インスタンス変数
		@post_comment = PostComment.new# 空のインスタンス変数作成
    end

# 投稿画像削除機能
	def destroy # 7 削除
		@post_image = PostImage.find(params[:id])
    	@post_image.destroy# 取得した投稿を削除
    	redirect_to post_images_path# 投稿画面へリダイレクト
	end

	private
		def post_image_params
			params.require(:post_image).permit(:shop_name, :image, :caption)
		end
end