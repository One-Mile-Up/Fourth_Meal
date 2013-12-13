require "./test/test_helper"

class DashboardPageWorksTest < Capybara::Rails::TestCase

  test "non admins user can not access dashboard" do
    user = User.new(username: 'non admin', password: 'password', email: 'non_admin@example.com')
    user.save

    visit admin_dashboard_path

    refute_equal current_path, admin_dashboard_path
  end

  test "admin user can access the dashboard" do
    user = User.new({username: 'admin', password: 'password', email: 'admin@example.com'})
    user.admin = true
    user.save!

    visit root_path
    click_on "Login"

    fill_in "Username", with: "admin"
    fill_in "Password", with: "password"
    click_button "Login"

    visit admin_dashboard_path
    assert_equal admin_dashboard_path, current_path
  end
end
