class Timetable < ApplicationRecord
    has_many :lectures,dependent: :destroy
    validates :term,presence: true
    validates :user_id,presence: true
end
