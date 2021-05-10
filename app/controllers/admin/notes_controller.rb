module Admin
  class NotesController < ::AdminController
    def index
      @employees = current_employee.team.employees.active.order(:name)
      @votes = Feedback::Finder.new(current_employee, params.merge(team_id: current_employee.team.id)).all
      @notes = Notes::Finder.new(current_employee, params).all
    end

    def create
      @note = current_employee.notes.create(note_params)

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.prepend(
            "notes",
            partial: 'admin/notes/note', locals: { note: @note }
          )
        end
        format.html { redirect_to admin_notes_url, notice: I18n.t('todosList.todoCreated') }
      end
    end

    def update
      @note = current_employee.notes.active.find(params[:id])
      @note.update(done: true)

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.remove("note_#{@note.id}")
        end
        format.html { redirect_to admin_notes_url, notice: I18n.t('todosList.todoCreated') }
      end
    end

    private

    def note_params
      params.require(:note).permit(%i[description receiver_id shared])
    end
  end
end
