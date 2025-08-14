require "test_helper"

class BlockchainControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_url  # <- Correção
    assert_response :success
  end
end
