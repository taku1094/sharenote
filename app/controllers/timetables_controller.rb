class TimetablesController < ApplicationController
    before_action :set_timetables
    before_action :set_timetable
    before_action :access_restriction,only: [:edit]
    before_action :restrict_user,only: [:index,:new,:edit,:show]
    def restrict_user
        if !(user_signed_in?)
            redirect_to('/home')
            flash[:alert] = "ログインしてください。"
        end
    end
    
    def set_timetables
        @timetables = Timetable.where(user_id: current_user.email).order(created_at: 'desc')
    end
    
    def set_timetable
        @timetable = Timetable.find_by(id: params[:id])
    end
    
    def access_restriction
        if current_user.email != @timetable.user_id
            redirect_to(timetables_path)
            flash[:notice] = "権限がありません。"
        end
    end
    
    def index
    end
    
    def new
        @timetable = Timetable.new
    end
    
    def create
        @timetable = Timetable.new(timetable_params)
        if @timetable.save
            flash[:notice] = "作成完了"
            redirect_to(timetables_path)
        else
            render "new"
        end
    end
    
    def show
    end
    
    def edit
    end
    
    def update       
        if @timetable.update(timetable_params)
            flash[:notice] = "編集完了"
            redirect_to(timetable_path(@timetable))
        else
            render "edit"
        end
    end
    
    def destroy
        @timetable.destroy
        redirect_to(timetables_path)
    end
    
   private
    def timetable_params
        params.require(:timetable).permit(:term,:user_id,:memo)
    end
end
