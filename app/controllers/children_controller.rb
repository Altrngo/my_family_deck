class ChildrenController < ApplicationController
  before_action :authenticate_user!                                   # Devise : obligé d'être connecté
  before_action :set_child, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, except: [:index, :new, :create]     # vérifie l'accès pour les actions sensibles

  def index
    # Tous les enfants auxquels l'utilisateur a accès (via ChildAccess)
    @children = current_user.children.order(:name)
  end

  def show
    # @child est déjà chargé par set_child + authorize_user! garantit l'accès
  end

  def new
    @child = child.new
  end

  def create
    @child = Child.new(child_params)
    @child.owner = current_user  # le créateur est le propriétaire principal

    if @child.save
      # Crée automatiquement l'accès "parent" pour le créateur
      @child.child_accesses.create!(user: current_user, role: :parent)

      redirect_to @child, notice: "Profil enfant créé avec succès !"
    else
      render :new
    end
  end

  def edit
    # Modifiable uniquement par le role parent
    require_parent_role!
  end

  def update
      require_parent_role!

      if @child.update(child_params)
        redirect_to @child, notice: "Profil enfant mis à jour."
      else
        render :edit
      end
  end

  # DELETE /children/1
  def destroy
    require_parent_role!
    @child.destroy
    redirect_to children_url, notice: "Profil enfant supprimé."
  end

  private

  def set_child
    @child = Child.find(params[:id])
  end

  # Vérifie que l'utilisateur a un accès à cet enfant
  def authorize_user!
    @child_access = current_user.child_accesses.find_by(child: @child)
    if @child_access.nil?
      redirect_to root_path, alert: "Vous n'avez pas accès à cet enfant."
    end
  end

  # Vérifie que l'utilisateur a le rôle "parent" sur cet enfant
  def require_parent_role!
    authorize_user! # d'abord vérifier l'accès général
    unless @child_access.parent?
      redirect_to @child, alert: "Seuls les parents peuvent effectuer cette action."
    end
  end

  def child_params
    params.require(:child).permit(:name, :birth_date, :gender)
  end
end
