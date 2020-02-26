class ApplicationController < ActionController::Base
	# Meshiterroでは、ログイン認証が成功していないと、どの画面も表示できない仕様にしたいと思います。
	# before_actionメソッドは、このコントローラが動作する前に実行されます。
	# 今回の場合、app/controllers/application_controller.rbファイルに記述したので、すべてのコントローラで、最初にbefore_actionメソッドが実行されます。
	# authenticate_userメソッドは、devise側が用意しているメソッドです。
	# :authenticate_user!とすることによって、「ログイン認証されていなければ、ログイン画面へリダイレクトする」機能を実装できます。
	before_action :authenticate_user!
	# 今回は、初期設定では用意されていないカラム（name）を追加しているので、これを追記します。
    before_action :configure_permitted_parameters, if: :devise_controller?
    # private:クラス内のみアクセス可能(自分のコントローラ内でしか参照できません)
    # protected:クラス内、同一パッケージ、サブクラスからアクセス可(呼び出された他のコントローラからも参照できます)
  	protected
	def configure_permitted_parameters
		# .permitメソッドで変更を加えられる（保存の処理ができる）キーを指定します。(検索、比較、整列（並べ替え）などに用いられるデータのことをキーということがある。)
    	devise_parameter_sanitizer.permit(:sign_up, keys: [:name])# permit=許可
 	end

end

Refile.secret_key = '4e434f3dac197227ca0e8ce53f8de0ce7027082ffcac0b967e72301439286af60428f672e9fc60e1a756153cf22f9e2cf701d7b3d40887925b6ab2939ed2d646'
