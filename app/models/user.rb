class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise設定時点でuser.rbファイルも自動作成され、Userモデルが定義されています。
  # このモデルには、deviseで利用する機能が記述されています。
	# 「:database_authenticatable, :registerable,」のように、deviseの後ろに :（コロン）で始まる部分がdeviseの機能名です。
	# :database_authenticatable（パスワードの正確性を検証）
	# :registerable（ユーザ登録や編集、削除）
	# :recoverable（パスワードをリセット）
	# :rememberable（ログイン情報を保存）
	# :validatable（emailのフォーマットなどのバリデーション）
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Userモデルに対して、PostImageモデルが1:Nになるよう関連付けます。
  # has_many(参照される側)の後には、1:Nの関係になるモデル名を複数形で記述します。
  has_many :post_images, dependent: :destroy# dependent=従属関係の
  # Userモデルに、PostImageモデルとの関連付けを記述します。PostCommentモデルとの1:Nの関係も実装します。
  has_many :post_comments, dependent: :destroy
  # Favoriteモデルのカラム（user_idとpost_image_id）は、UserモデルのidやPostImageモデルのidと関連付けが必要です。
  has_many :favorites, dependent: :destroy
  # 以下の2つは、refileを使用するうえでのルールです。（画像投稿機能）
	# 指定するフィールド名は、profile_image_idから_idを除いた名前（profile_image）を指定します。
	# また、モデルにも、画像アップ用のメソッド（attachment_field）を追加します。
  attachment :profile_image# refileを使って、画像投稿ができるようにします。その際、refile特有の記述ルールに注意しましょう。（id不要）
end
