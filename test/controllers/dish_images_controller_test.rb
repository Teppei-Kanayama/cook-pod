require 'test_helper'

class DishImagesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get dish_images_create_url
    assert_response :success
  end

end
