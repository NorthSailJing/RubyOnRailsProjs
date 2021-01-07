require 'rails_helper'

RSpec.describe Task, type: :model do
    let(:user) { create(:user) }
    let!(:task1) { create(:task, user: user, status: 1) }
    let!(:task2) { create(:task, user: user, status: 1) }
    let!(:task3) { create(:task, user: user, status: 0) }    
        
    it "completed hours calculating" do
        expect(Task.completed_hours).to eq(task1.duration+task2.duration)
    end    
end    