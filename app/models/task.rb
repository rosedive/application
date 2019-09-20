class Task < ApplicationRecord
    # validates :name, presence: true
    #  validates :status, presence: true
    # validates :content, presence: true
    # validates :priority, presence: true
    # validates :start_date, presence: true
    # validates :end_date, presence: true
    
    def self.search(search)
      if search
      where("status LIKE ?" ,"%#{search}%")
    end
  end
def self.order_list(sort_order)
    if sort_order == "name"
      order(name: :desc)
    elsif sort_order == "end_date"
      order(end_date: :desc)
    else
      order(start_date: :desc)
    end
   end
end
