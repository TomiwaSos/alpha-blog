require "test_helper"

class SignupUsersTest < ActionDispatch::IntegrationTest
  test "get sign up form and create a new user" do
    get '/signup'
    assert_response :success
    assert_difference 'User.count', 1 do
      post users_path, params: {user: {username: 'test',email: 'test@example.com', password: 'password'} }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match 'test', response.body
  end

  test "get sign up form and reject invalid user" do
    get '/signup'
    assert_response :success
    assert_no_difference 'User.count' do
      post users_path, params: {user: {username: 'test',email: 'test@example', password: 'password'} }
    end
    assert_match 'errors', response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end
end
