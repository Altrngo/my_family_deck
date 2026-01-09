class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_child
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authorize_access!, except: [:index, :new, :create]
  before_action :require_parent_role!, only: [:destroy]

  def index
    @events = @child.events.chronological
  end

  def new
    @event = build_event_from_type(params[:type] || "Biberon")
  end

  def create
    @event = build_event_from_type(event_params[:type])
    @event.attributes = event_params.except(:type)
    @event.user = current_user
    @event.child = @child
    @event.start_time ||= Time.current

    # Debug ici
    puts "Classe de l'événement : #{@event.class.name}"
    puts "Valid ? #{@event.valid?}"
    puts "Erreurs : #{@event.errors.full_messages.inspect}" if @event.invalid?

    if @event.save
      redirect_to child_events_path(@child), notice: "Événement enregistré !"
    else
      puts "Save échoué - erreurs : #{@event.errors.full_messages}"
      render :new, status: :unprocessable_entity
    end
  end


  def edit
    
  end

  def show
    
  end

  def update
    if @event.update(event_params)
      redirect_to child_events_path(@child), notice: "Evènement modifié avec succès."
    else
    render :edit, status: :unprocessable_entity
    end 
  end

  def destroy
    @event.destroy
    redirect_to child_events_path(@child), notice: "Evènement supprimé."
  end

  private

  def set_child
    @child = Child.find(params[:child_id])
  end

  def set_event
    @event = @child.events.find(params[:id])
  end

  def authorize_access!
    @child_access = current_user.child_accesses.find_by(child: @child)
    return redirect_to root_path, alert: "Accès refusé." unless @child_access

    allowed_roles = %w[parent family garde médical]
    redirect_to @child, alert: "Vous n'avez pas le droit d'ajouter des événements." unless @child_access.role.in?(allowed_role)
  end


  def require_parent_role!
    @child_access = current_user.child_accesses.find_by(child: @child)
    redirect_to @child, alert: "Seuls les parents peuvent supprimer un évènement." unless @@child_access&.role = "parent"
  end

  def build_event_from_type(type)
    case type
    when "Biberon" then Biberon.new
    when"Bobo" then Bobo.new
    when "Couche" then Couche.new
    when "Dodo" then Dodo.new
    when"Evenement" then Evenement.new
    when"Maladie" then Maladie.new
    when"Medicament" then Medicament.new
    when "Poids" then Poids.new
    when"Repas" then Repas.new
    when"Taille" then Taille.new
    when "Temperature" then Temperature.new
    when"Vaccin" then Vaccin.new
    # Ajoute les autres au fur et à mesure
    else Event.new(type: type)
    end
  end

  def event_params
    params.require(:event).permit(
      :type, :start_time, :end_time,
      :value_float, :value_string,
      :comment, :parent_validation, :created_at, :updated_at
    )
  end
end
