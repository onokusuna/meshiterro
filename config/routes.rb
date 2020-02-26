Rails.application.routes.draw do
  # devise設定時点でルーティングが自動的に追加されています。
  # devise_for :usersは、deviseを使用する際にURLとしてusersを含むことを示しています。
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # deviseでは、ログイン認証が成功した場合、config/routes.rbファイル内で設定されているrootパスへリダイレクトされます。
  # 下記未記入ではrootパスが設定されていないため、初期設定の「Yay! You’re on Rails!」画面へリダイレクトされます。
  # ログイン認証が成功した後、投稿画像の一覧画面が表示されるように設定します。
  root 'post_images#index'
  # resources :リソース名, only:(オプション) [:new, :create, :index, :show](のアクションのルートだけ作る)
  # onlyは、生成するルーティングを限定するオプションです。
  resources :post_images, only: [:new, :create, :index, :show, :destroy] do # コメントは、投稿画像に対してコメントされます。このため、post_commentsは、post_imagesに結びつきます。
  	resource :favorites, only: [:create, :destroy]# resourceなのは単数にすると、そのコントローラのidがリクエストに含まれなくなります。
  	resource :post_comments, only: [:create, :destroy]# post_commentsのshowページが不要で、idの受け渡しも必要ないので、resourceとなっています。
  end# doの後にはend
  resources :users, only: [:show, :edit, :update]# マイページ作成、編集可能
end# doの後にはend