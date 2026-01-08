class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_child
  before_action :authorize_access!

  def index
    @events = @child.events.chronological
  end

  def new
    @event = @child.events.build(start_time: Time.current, type: params[:quick_type])
  end

  def create
    @event = @child.events.build(event_params)
    @event.start_time ||= Time.current

    if @event.save
      redirect_to child_events_path(@child), notice: "Événement enregistré !"
    else
      render :new
    end
  end

  private

  def set_child
    @child = Child.find(params[:child_id])
  end

  def authorize_access!
    @child_access = current_user.child_accesses.find_by(child: @child)
    return redirect_to root_path, alert: "Accès refusé." if @child_access.nil?

    allowed_roles = %w[parent family garde médical]
    return if @child_access.role.in?(allowed_roles)

    redirect_to @child, alert: "Vous n'avez pas le droit d'ajouter des événements."
  end

  def event_params
    params.require(:event).permit(
      :type, :start_time, :end_time,
      :value_float, :value_string,
      :comment, :parent_validation, :created_at, :updated_at
    )
  end
end
