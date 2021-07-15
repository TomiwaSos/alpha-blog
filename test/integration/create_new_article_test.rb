require "test_helper"

class CreateNewArticleTest < ActionDispatch::IntegrationTest
  
  setup do 
    @user = User.create(username: "test", email: "test@test.com", password: "password", admin: false)
    sign_in_as(@user)
  end

  test "get new article form and create an article" do
    get '/articles/new'
    assert_response :success
    assert_difference 'Article.count', 1 do
      post articles_path, params: {article: {title: 'test title', description:'this is the description for the test'}}
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match 'test title', response.body
  end

  test "get new article form and reject invalid" do
    get '/articles/new'
    assert_response :success
    assert_no_difference 'Category.count' do
      post articles_path, params: {article: {title: '', description:''} }
    end
    assert_match 'errors', response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end

end
