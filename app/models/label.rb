class Label < ApplicationRecord
  belongs_to :user
  has_many :tasks_labels, dependent: :destroy
 has_many :tasks, through: :tasks_labels
end
