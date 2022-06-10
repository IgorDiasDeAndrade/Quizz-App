class AdminsBackoffice::AdminsController < AdminsBackofficeController
  
  before_action :set_admin, only: [:edit, :update, :destroy]
  
  def index
    @admins = Admin.all.page(params[:page]).per(5)
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save()
      redirect_to admins_backoffice_admins_path, notice: "Criado"
    else
      render :new
    end
  end


  def edit
  end

  def update
    if @admin.update(admin_params)
      redirect_to admins_backoffice_admins_path, notice: "Atualizado com sucesso!"
    else
      render :edit
    end
  end

  def destroy
    if @admin.destroy
      redirect_to admins_backoffice_admins_path, notice: "excluido com sucesso!"
    else
      render :index
    end
  end


  private

  def set_admin
    @admin = Admin.find(params[:id])
  end

  def admin_params
    params_admin = params.require(:admin).permit(:email, :password, :password_confirmation)
  end

end
