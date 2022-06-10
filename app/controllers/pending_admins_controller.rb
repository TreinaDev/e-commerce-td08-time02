class PendingAdminsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @pending_admins = Admin.pending
  end

  def approve
    admin = Admin.find(params[:id])
    admin.approved!

    redirect_to pending_admins_path, notice: t('admin_approved')
  end
end
