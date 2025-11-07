# CoreUI 4 Rails Starter

## Project Overview

This is a Ruby on Rails starter template that uses the [CoreUI](https://coreui.io/) theme for the user interface. It's a good starting point for building a modern, responsive web application with a pre-built design system.

The project is configured with:

*   **Backend:** Ruby on Rails
*   **Frontend:** Shakapacker (a successor to Webpacker) for managing JavaScript, with Stimulus, jQuery, and the CoreUI library.
*   **Authentication:** Devise for user authentication.
*   **Authorization:** Pundit for managing user permissions.
*   **Database:** SQLite3 for development.
*   **Testing:** Capybara and Selenium for system testing.
*   **Deployment:** Capistrano for automating deployment.

## Building and Running

To get the application running locally:

1.  **Install dependencies:**
    ```bash
    bundle install
    pnpm install
    ```

2.  **Set up the database:**
    ```bash
    rails db:create
    rails db:migrate
    rails db:seed
    ```

3.  **Run the development server:**
    ```bash
    ./bin/shakapacker-dev-server
    ```
    In another terminal:
    ```bash
    rails s
    ```

The application should now be running at `http://localhost:3000`.

### Testing

To run the test suite:

```bash
bundle exec rspec
```

## Development Conventions

*   **Code Style:** The project uses `standard` for Ruby code style. You can run `bundle exec standardrb` to check for and fix style issues.
*   **JavaScript:** JavaScript is managed with Shakapacker and located in `app/javascript`. The project uses Stimulus for modest JavaScript enhancements.
*   **Internationalization (I18n):** The project uses `devise-i18n` for Devise translations. You can find other locale files in `config/locales`.
*   **Views:** The views are built with standard Rails ERB templates and make use of CoreUI components.
