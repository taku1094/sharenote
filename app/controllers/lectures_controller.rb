class LecturesController < ApplicationController
    before_action :set_lectures
    before_action :set_lecture
    before_action :set_timetable
    before_action :access_restriction,only: [:edit]
   before_action :restrict_user,only: [:index,:new,:edit,:show]
    def restrict_user
        if !(user_signed_in?)
            redirect_to('/home')
            flash[:alert] = "ログインしてください。"
        end
    end
    
    def set_lectures
        @lectures = Lecture.all.order(created_at: 'desc')
    end
    
    def set_lecture
        @lecture = Lecture.find_by(id: params[:id])
    end
    
     def set_timetable
        @timetable = Timetable.find_by(id: params[:timetable_id])
     end
    
     def access_restriction
        if current_user.email != @lecture.user_id
            redirect_to(timetables_path)
            flash[:notice] = "権限がありません。"
        end
    end
    
    def index
    end
    
    def new
        @lecture = Lecture.new
    end
    
    def create
        @lecture = Lecture.new(lecture_params)
        if @lecture.save
            flash[:notice] = "投稿完了"
            redirect_to(timetable_path(@timetable))
        else
            render "new"
        end
    end
    
    def show
        @documents = Document.where(lecture_id: @lecture.id)
    end
    
    def edit
    end
    
    def update       
        if @lecture.update(lecture_params)
            flash[:notice] = "編集完了"
            redirect_to(timetable_lecture_path(@timetable,@lecture))
        else
            render "edit"
        end
    end
    
    def destroy
        @timetable = Timetable.find_by(id: @lecture.term)
        @lecture.destroy
        redirect_to(timetable_path(@timetable))
    end
    
   private
    def lecture_params
        params.require(:lecture).permit(:name,:date,:time,:professor,:room,:memo,:term,:user_id)
    end
end
