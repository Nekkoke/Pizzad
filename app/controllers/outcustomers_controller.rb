class OutcustomersController < ApplicationController
   
    # 会員の削除
    def destroy
    # アカウント削除
    if current_customer
    current_customer.destroy
    else
    current_employee.destroy
    end

    # トップページにリダイレクト
    redirect_to root_path, notice: "アカウントが削除されました。当サービスのご利用ありがとうございました。"
    end
end
