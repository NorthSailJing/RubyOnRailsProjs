require "rails_helper"

RSpec.describe "tasks management", type: :system do
  include Devise::TestHelpers

  before do
    user = {email: "jing@northsail.io", password: "wjl113"}
    @user = User.Create!(user)
    sign_in(@user)
  end

  it "some test" do

  end
end
