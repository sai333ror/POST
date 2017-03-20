require 'test_helper'

class PpostsControllerTest < ActionController::TestCase
  setup do
    @ppost = pposts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pposts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ppost" do
    assert_difference('Ppost.count') do
      post :create, ppost: { body: @ppost.body, title: @ppost.title }
    end

    assert_redirected_to ppost_path(assigns(:ppost))
  end

  test "should show ppost" do
    get :show, id: @ppost
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ppost
    assert_response :success
  end

  test "should update ppost" do
    patch :update, id: @ppost, ppost: { body: @ppost.body, title: @ppost.title }
    assert_redirected_to ppost_path(assigns(:ppost))
  end

  test "should destroy ppost" do
    assert_difference('Ppost.count', -1) do
      delete :destroy, id: @ppost
    end

    assert_redirected_to pposts_path
  end
end
