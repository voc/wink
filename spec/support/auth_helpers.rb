module AuthHelpers
  def sign_in_as_test_user
    user = User.create!(email: "spec@example.com", name: "SpecUser", provider: "oidc", uid: "spec")
    session[:user_id] = user.id
  end
end

RSpec.configure do |config|
  config.include AuthHelpers, type: :controller
end