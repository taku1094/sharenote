class NotesController < ApplicationController
    before_action :set_notes
    before_action :set_note
    before_action :set_timetable_and_lecture,only: [:index,:show,:add,:delete]
    before_action :access_restriction,only: [:edit]
    before_action :restrict_user,only: [:index,:new,:edit,:show]
    def restrict_user
        if !(user_signed_in?)
            redirect_to('/home')
            flash[:alert] = "ログインしてください。"
        end
    end
    def set_notes
        @notes = Note.all.order(created_at: 'desc')
    end
    
    def set_note
        @note = Note.find_by(id: params[:id])
    end
    
    def set_timetable_and_lecture
        @timetable = Timetable.find_by(id: params[:timetable_id])
        @lecture = Lecture.find_by(id: params[:lecture_id])
    end
    
    def access_restriction
        if current_user.email != @note.user_id
            redirect_to(notes_path)
            flash[:notice] = "権限がありません。"
        end
    end
    
    def index
        @notes = Note.page(params[:page]).search(params[:search])
    end
    
    def new
        @note = Note.new
    end
    
    def create
        @note = Note.new(note_params)
        if @note.save
            flash[:notice] = "投稿完了"
            redirect_to(notes_path)
        else
            render "new"
        end
    end
    
    def show
        @document = Document.new
    end
    
    def edit
    end
    
    def update       
        if @note.update(note_params)
            flash[:notice] = "編集完了"
            redirect_to(note_path(@note))
        else
            render "edit"
        end
    end
    
    def destroy
        @note.destroy
        redirect_to(notes_path)
    end
    
    def add
        @document = Document.new(document_params)
         if @document.save
            flash[:notice] = "追加完了"
            redirect_to(timetable_lecture_path(@timetable,@lecture))
        else
            render "/"
        end
    end
    
    def delete
        @document = Document.find_by(note_id: params[:note_id],lecture_id: params[:lecture_id])
        @document.destroy
        redirect_to(timetable_lecture_path(@timetable,@lecture))
    end
    
   private
    def note_params
        params.require(:note).permit(:title, :content, :user_id)
    end
    
    private
    def document_params
        params.require(:document).permit(:note_id, :lecture_id, :timetable_id)
    end
end
