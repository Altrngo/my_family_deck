class UsersController < Devise::RegistrationsController
  before_action :authenticate_user!, only: [:edit, :update]

  # GET /users/sign_up (inscription)
  def new
    super # laisse Devise faire son travail, mais on pourra surcharger la vue
  end

  # POST /users (création du compte)
  def create
    super do |user|
      if user.persisted?
        # Optionnel : actions après inscription réussie
      end
    end
  end

  # GET /users/edit (édition du profil)
  def edit
    @user = current_user
  end

  # PATCH/PUT /users (mise à jour du profil)
  def update
    @user = current_user

    # Devise demande le current_password pour changer email/mot de passe
    if user_params[:password].blank?
      user_params.delete(:password)
      user_params.delete(:password_confirmation)
    end

    if @user.update(user_params)
      bypass_sign_in(@user) # pour éviter de se déconnecter après changement email
      redirect_to root_path, notice: "Profil mis à jour avec succès !"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation,
      :current_password,
      :first_name,
      :last_name,
      :nickname,
      :birth_date,
      :phone_number
    )
  end

  # Optionnel : rediriger après inscription
  def after_sign_up_path_for(resource)
    root_path
  end
end