class OutcustomersController < ApplicationController
   
    # 会員の削除
    def destroy
    # アカウント削除
    current_customer.destroy
    
    # トップページにリダイレクト
    redirect_to root_path, notice: "アカウントが削除されました。"
    end
end
