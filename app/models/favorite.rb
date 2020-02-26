class Favorite < ApplicationRecord
	# Favoriteモデルに関連付けを追加する
	belongs_to :user
	belongs_to :post_image
end
