require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = "Babbit"
  end

  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "#{@base_title}"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "Babbitとは | #{@base_title}"
  end

  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "お問い合わせ | #{@base_title}"
  end

  test "should get terms" do
    get terms_path
    assert_response :success
    assert_select "title", "利用規約 | #{@base_title}"
  end

  test "should get policy" do
    get policy_path
    assert_response :success
    assert_select "title", "プライバシーポリシー | #{@base_title}"
  end

end
