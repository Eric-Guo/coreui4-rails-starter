# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Rails 7.2.1 application using the CoreUI 4 admin template. It features user authentication (Devise), role-based authorization (Pundit), pagination (Pagy), and a Stimulus-powered frontend with Shakapacker (Webpack 5) for asset compilation. The app supports both English and Chinese (zh-CN) locales.

## Architecture

### Directory Structure

- **app/**: Core Rails application code
  - `controllers/`: Organized by feature (accounts/, admin/, ui/, users/)
  - `models/`: User, Role, and UserRole with Pundit authorization policies in `policies/`
  - `views/`: ERB templates organized by controller namespace
  - `javascript/`: Stimulus controllers in `controllers/`, entry bundles in `packs/`, SCSS in `stylesheets/`
  - `policies/`: Pundit authorization policies (ApplicationPolicy, UserPolicy, RolePolicy, UserRolePolicy)
  - `datatables/`: AjaxDataTables for server-side table rendering

- **config/**: Configuration files
  - `settings/`: Environment-specific settings via Config gem
  - `routes/`: Admin namespace routes in separate file
  - `initializers/`: Devise, Pagy, MetaTags, CSP configurations
  - `locales/`: i18n translations for en and zh-CN

- **bin/**: Wrapper scripts
  - `setup`: Full project initialization (installs gems, pnpm packages, prepares database)
  - `rails`: Standard Rails commands
  - `shakapacker` / `shakapacker-dev-server`: Asset compilation and HMR server
  - `brakeman`: Security scanner
  - `rubocop`: StandardRB linting

## Common Commands

### Development
```bash
# Initial setup (one time)
bin/setup

# Start Rails server with asset compilation
bin/rails server
bin/shakapacker-dev-server  # In separate terminal for HMR

# Apply database migrations
bin/rails db:migrate
bin/rails db:rollback STEP=1  # Rollback last migration
```

### Testing
```bash
# Run all tests
bin/rails test

# Run system tests (Capybara)
bin/rails test:system

# Run specific test file
bin/rails test test/controllers/home_controller_test.rb
```

### Code Quality
```bash
# Run StandardRB linter
bundle exec standardrb

# Auto-fix StandardRB issues
bundle exec standardrb --fix

# Run security scanner
bin/brakeman
```

### Frontend Assets
```bash
# Build production assets
bin/shakapacker

# Install pnpm dependencies
pnpm install

# Compile assets for test environment
NODE_ENV=test bin/shakapacker
```

## Key Technologies

- **Backend**: Rails 7.2.1, Ruby 3.1+, SQLite3, Redis adapter (optional)
- **Frontend**: CoreUI 4, Stimulus 3.2, Shakapacker 8 (Webpack 5)
- **Authentication**: Devise with i18n
- **Authorization**: Pundit policies
- **UI Components**: CoreUI 4, jQuery, DataTables, Selectize
- **Charts**: Chart.js 3.9 via @coreui/chartjs
- **Linting**: StandardRB (extends RuboCop)
- **Testing**: Minitest, Capybara, Selenium
- **Deployment**: Capistrano with pnpm, rbenv, and Puma support
- **CI**: GitLab CI with stages for standardrb, test, and system tests

## Important Conventions

### Naming
- Stimulus controllers: `*_controller.js` files in `app/javascript/controllers/`
- SCSS files: Match pack names (e.g., `dashboard.scss` for `dashboard.js`)
- Database columns and methods: snake_case

### Code Style
- Ruby: StandardRB style (2-space indentation, double quotes preferred)
- Run `bundle exec standardrb --fix` before committing
- Keep migrations reversible

### Development Notes

#### Hot Module Replacement (HMR)
For SCSS debugging, enable HMR in `config/shakapacker.yml`:
```yaml
hmr: true
```

#### Webpack 5 Loading Order
Always include Stimulus in packs due to webpack 5's loading sequence requirements.

#### VSCode Debugging
Install `Ruby LSP` (Shopify) and `VSCode rdbg Ruby Debugger` (KoichiSasada). Ensure only one version of the `debug` gem is installed as a default gem.

## Route Structure

- `/`: Home page (home#index)
- `/account/profile`: User profile management (show, update)
- `/admin/*`: Admin namespace for user and role management
- `/ui/*`: UI component demonstrations (avatar_area, nav_group_items, user_select)
- User authentication routes via Devise (sessions, passwords, registrations)
- `/up`: Health check endpoint for load balancers

## Environment Configuration

- Credentials: Managed via `bin/rails credentials:edit`
- Environment settings: `config/settings/*.yml` files (development, test, production)
- Database: SQLite3 for all environments
- Locales: English and Chinese (zh-CN), default is zh-CN (config/application.rb:40)

## Security

- Use `bin/brakeman` before releases to scan for security issues
- Store secrets via Rails credentials, never commit to `config/settings`
- All admin endpoints protected by Pundit policies
- Default admin/sample data kept out of production branches

## Deployment

Configured for Capistrano deployment with:
- pnpm integration (`capistrano-pnpm`)
- rbenv support (`capistrano-rbenv`)
- Puma server management (`capistrano3-puma`)
- Production configuration in `config/deploy/production.rb`
- Systemd service configuration in `config/systemd/`
