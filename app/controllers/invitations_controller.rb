class InvitationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_child
  before_action :require_parent_role!

  def create
    invited_user = User.find_by(email: params[:email].downcase.strip)

    if invited_user.nil?
      redirect_to @child, alert: "Aucun compte trouvé avec cet email. La personne doit d'abord s'inscrire sur l'application."
      return
    end

    if @child.users.include?(invited_user)
      redirect_to @child, alert: "#{invited_user.email} a déjà accès à ce profil."
      return
    end

    @child.child_accesses.create!(user: invited_user, role: params[:role])

    redirect_to @child, notice: "#{invited_user.email} a été ajouté(e) avec le rôle #{params[:role].capitalize}."
  end

  private

  def set_child
    @child = Child.find(params[:child_id])
  end

  def require_parent_role!
    @child_access = current_user.child_accesses.find_by(child: @child)
    unless @child_access&.parent?
      redirect_to root_path, alert: "Seuls les parents peuvent inviter d'autres personnes."
    end
  end
end
