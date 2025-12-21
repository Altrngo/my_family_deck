require "test_helper"

class ChildrenControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get children_index_url
    assert_response :success
  end

  test "should get show" do
    get children_show_url
    assert_response :success
  end

  test "should get new" do
    get children_new_url
    assert_response :success
  end

  test "should get create" do
    get children_create_url
    assert_response :success
  end

  test "should get edit" do
    get children_edit_url
    assert_response :success
  end

  test "should get update" do
    get children_update_url
    assert_response :success
  end

  test "should get destroy" do
    get children_destroy_url
    assert_response :success
  end
end
