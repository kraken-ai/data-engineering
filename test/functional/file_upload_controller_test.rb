require 'test_helper'

class FileUploadControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test "should get new" do
    sign_in :user, user
    get :new
    assert_response :success
  end

  test "should get complete" do
    sign_in :user, user
    get :complete
    assert_response :success
  end

  test "should post to file_upload/new" do
    sign_in :user, user
    file = Rack::Test::UploadedFile.new("#{Rails.root.join('test','data', 'test1.tab')}", "text/plain")
    post :create, :filename => file
    assert_response :success
    assert_template :complete
  end

  test "should fail posting to file_upload/new" do
    sign_in :user, user
    file = nil
    post :create, :filename => file
    assert_response :success
    assert_template :new
  end
end