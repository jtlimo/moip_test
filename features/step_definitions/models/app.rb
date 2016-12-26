# module to instanciate only once the pages
module App
  def login_page
    LoginPage.new
  end

  def account_summary
    AccountSummaryPage.new
  end

  def order_details
    OrderDetailsPage.new
  end
end
World(App)
