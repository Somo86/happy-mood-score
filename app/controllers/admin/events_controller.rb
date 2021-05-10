module Admin
  class EventsController < AdminController
    before_action :find_event, only: %i[edit update destroy]

    def index
      @events = current_company.events.order(:name).page(params[:page])
    end

    def new; end

    def edit; end

    def create
      @event = current_company.events.create(event_params)

      if @event.errors.empty?
        redirect_to admin_events_path, notice: 'Event created successfully.'
      else
        render partial: 'form'
      end
    end

    def update
      @event.update(update_params.merge(id: params[:id]))

      if @event.errors.empty?
        redirect_to admin_events_path, notice: 'Event updated successfully.'
      else
        render partial: 'form'
      end
    end

    def destroy
      @event.destroy

      if @event.errors.empty?
        redirect_to admin_events_path, notice: 'Event deleted successfully.'
      else
        redirect_to admin_events_path, error: 'Active events can not be deleted.'
      end
    end

    private

    def event_params
      params.require(:event).permit(%i[name description value])
    end

    def update_params
      event_params.merge(id: params[:id])
    end

    def destroy_params
      params.require(:id)
    end

    def find_event
      @event = current_company.events.find_by!(uuid: params[:id])
    end
  end
end
