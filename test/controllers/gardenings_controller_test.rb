require 'test_helper'

class GardeningsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @gardening = gardenings(:one)
  end

  test "should get index" do
    get gardenings_url
    assert_response :success
  end

  test "should get new" do
    get new_gardening_url
    assert_response :success
  end

  test "should create gardening" do
    assert_difference('Gardening.count') do
      post gardenings_url, params: { gardening: { content: @gardening.content, description: @gardening.description, name: @gardening.name } }
    end

    assert_redirected_to gardening_url(Gardening.last)
  end

  test "should show gardening" do
    get gardening_url(@gardening)
    assert_response :success
  end

  test "should get edit" do
    get edit_gardening_url(@gardening)
    assert_response :success
  end

  test "should update gardening" do
    patch gardening_url(@gardening), params: { gardening: { content: @gardening.content, description: @gardening.description, name: @gardening.name } }
    assert_redirected_to gardening_url(@gardening)
  end

  test "should destroy gardening" do
    assert_difference('Gardening.count', -1) do
      delete gardening_url(@gardening)
    end

    assert_redirected_to gardenings_url
  end
end
