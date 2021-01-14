class Client < ApplicationRecord
    has_many :tasks, dependent: :destroy
end
