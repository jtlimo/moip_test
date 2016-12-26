# AccountSummaryPage class
class AccountSummaryPage < SitePrism::Page
  element :table_last_orders, '#entries-rows'

  # TODO: improve this method
  def access_order_details(order_id)
    table_last_orders.all('td').each do |td|
      while td.text.strip != order_id
        sleep(2) # dumb wait before refresh page # TODO: use wait until methods
        page.driver.browser.navigate.refresh
        table_last_orders.all('td').each do |a|
          next unless a.text.strip == order_id
          a.click
          break
        end
        break
      end
      break unless has_table_last_orders?
      td.click if td.text.strip == order_id
      break
    end
  end
end
