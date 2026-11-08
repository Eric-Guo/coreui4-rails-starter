require "test_helper"
require "warden/test/helpers"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include Warden::Test::Helpers

  teardown do
    Warden.test_reset!
  end

  # removes noisy logs when launching tests
  Capybara.server = :puma, {Silent: true}
  Capybara.disable_animation = true

  chrome_args = %w[window-size=1400,1000]
  # CI containers restrict Chrome's sandbox and shared memory.
  chrome_args.concat(%w[no-sandbox disable-dev-shm-usage]) if ENV["CI"]

  Capybara.register_driver :headless_chrome do |app|
    options = Selenium::WebDriver::Chrome::Options.new(args: ["headless", *chrome_args])
    Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
  end

  Capybara.register_driver(:chrome) do |app|
    options = Selenium::WebDriver::Chrome::Options.new(args: chrome_args)
    Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
  end

  ENV["HEADLESS"] ? driven_by(:headless_chrome) : driven_by(:chrome)
end
