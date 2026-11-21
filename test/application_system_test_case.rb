require "test_helper"
require "warden/test/helpers"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include Warden::Test::Helpers

  module ChromeResetFallback
    def reset!
      super
    rescue Selenium::WebDriver::Error::InvalidArgumentError => error
      raise unless error.message.include?("invalid argument: * is not a valid URL")

      # Chrome 158 rejects Capybara 3.40's wildcard storage reset.
      # Closing the session gives the next test a clean browser profile.
      quit
    end
  end

  Capybara::Selenium::Driver::ChromeDriver.prepend(ChromeResetFallback)

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
