class AdminsBackoffice::AdminsController < AdminsBackofficeController
  def index
    @admins = Admin.all
  end

  def edit
    @admin = Admin.find(params[:id])#pega o id passado como parametro e acha o objeto que possui o id correspondente, o jogando pra variavel
  end
end
