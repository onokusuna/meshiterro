class PostImage < ApplicationRecord
	# has_manyとは逆の機能になります。
	# belongs_toは、PostImageモデルからuser_idに関連付けられていて、Userモデルを参照することができます。
	# PostImageモデルに関連付けられるのは、1つのUserモデルです。このため、単数形の「user」になっている点に注意しましょう。
	belongs_to :user
	# 画像アップロードは、%= f.attachment_field :image %で実装しています。
	# 以下の2つは、refileを使用するうえでのルールです。
		# 指定するフィールド名は、image_idから_idを除いた名前（image）を指定します。
		# また、モデルにも、画像アップ用のメソッド（attachment_field）を追加します。
	attachment :image # ここを追加（_idは含めません）
	# PostImageモデルとPostCommentモデルを関連付ける
	# has_many(参照される側)の後には、1:Nの関係になるモデル名を複数形で記述します。has_manyでPostCommentモデルを複数持つことを表しています。
	has_many :post_comments, dependent: :destroy# dependent=従属関係の
	# PostImageモデルに関連付けを追加する
	# favorited_by?メソッドを作成します。このメソッドで、引数で渡されたユーザidがFavoritesテーブル内に存在（exists?）するかどうかを調べます。
	# 存在していればtrue、存在していなければfalseを返すようにしています。
	has_many :favorites, dependent: :destroy
	# 今回、画像投稿に対して「必須入力」の設定が必要なので、PostImageモデルにデータ保存の記述を追加します。
	# validatesで対象とする項目を指定し、入力されたデータのpresence（存在）をチェックします。データが入っていれば、trueです。
	validates :shop_name, presence: true# presence=存在
    validates :image, presence: true
        def favorited_by?(user)
          favorites.where(user_id: user.id).exists?
        end
end
