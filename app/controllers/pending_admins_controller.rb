class PendingAdminsController < ApplicationController
  def index
    @pending_admins = Admin.pending
  end

  def approve
    admin = Admin.find(params[:id])
    admin.approved!

    redirect_to pending_admins_path, notice: 'Administrador aprovado com sucesso.'
  end
end
