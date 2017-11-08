class Note < ApplicationRecord
    validates :title,presence: true
    validates :content,presence: true
    
     def self.search(search)
        if search  
            Note.where(['title LIKE ?', "%#{search}%"])
        else
            Note.all
        end
    end
    
end
