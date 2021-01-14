require 'csv'

class Task < ApplicationRecord
  belongs_to :user
  belongs_to :client

  enum status: {pending: 0, completed: 1}

  scope :by_state, -> { order(status: :asc, id: :desc) }
  scope :completed_hours, -> { where(status: 1).sum(:duration) }
  scope :with_client, -> { includes(:client) }

  validates_presence_of :title, :body, :duration
  validates :duration, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 100 }

  def self.to_csv
    attributes  = %w{title body client_name duration status}

    CSV.generate(headers: true, row_sep: "\r\n", col_sep: "|") do |csv|
      csv << attributes 

      all.each do |task|
        csv << attributes.map{ |attr| task.send(attr) } 
      end  
    end   
  end  

  def client_name
    self.client.name
  end  

end
