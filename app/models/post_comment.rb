class PostComment < ApplicationRecord
	# UserモデルとPostCommentモデルを関連付ける。親＝参照される側、子＝参照する側
	belongs_to :user# 親：user、子：post_comment
    belongs_to :post_image# 親：post_image、子：post_comment
end