class Admin::EmployeesController < Admin::Base
    # 会員一覧
    def index
      @employees = Employee.order("id")
        .page(params[:page]).per(15)
    end
  
    # 検索
    def search
      @employees = Employee.search(params[:q])
        .page(params[:page]).per(15)
  
      render "index"
    end

    # 新規作成フォーム
    def new
      @employees = Employee.new
    end

    # 会員の新規登録
    def create
      @employees = Employee.new(params[:employee])
      if @employees.save
        redirect_to admin_employees_path, notice: "従業員を登録しました。"
      else
        render "new"
      end
    end

    # 会員の削除
    def destroy
      @employees = Employee.find(params[:id])
      @employees.destroy
    redirect_to :admin_employees, notice: "従業員を削除しました。"
    end
end
