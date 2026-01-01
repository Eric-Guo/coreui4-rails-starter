# Repository Guidelines

## Project Structure & Module Organization
- `app/`: Rails app code (controllers, models, views). Authorization policies live in `app/policies/`, server-side tables in `app/datatables/`.
- `app/javascript/`: Frontend assets with Stimulus controllers in `controllers/`, entry points in `packs/`, and SCSS in `stylesheets/`.
- `config/`: App configuration, `config/routes/` for route splits, and `config/settings/` for environment settings.
- `test/`: Minitest suite, including `test/system/` for system tests.
- `public/`, `db/`, `lib/`: Static assets, database migrations, and shared libraries/tasks.

## Build, Test, and Development Commands
- `bin/setup`: One-time setup; installs gems, pnpm packages, and prepares the database.
- `bin/rails server`: Run the Rails server locally.
- `bin/shakapacker-dev-server`: Run the Webpack HMR server (use with `bin/rails server`).
- `bin/rails db:migrate`: Apply migrations; use `bin/rails db:rollback STEP=1` when needed.
- `pnpm install`: Install frontend dependencies.
- `bin/shakapacker`: Build production assets.
- `bin/rails test` / `bin/rails test:system`: Run unit/integration tests and system tests.
- `bundle exec standardrb`: Lint Ruby code (StandardRB/RuboCop config).
- `bin/brakeman`: Run the security scanner before releases.

## Coding Style & Naming Conventions
- Ruby follows StandardRB (2-space indentation, double quotes). Prefer `bundle exec standardrb --fix` before committing.
- Stimulus controllers must be named `*_controller.js` under `app/javascript/controllers/`.
- SCSS files generally mirror pack names (e.g., `dashboard.scss` for `dashboard.js`).
- Use snake_case for database columns and Ruby method names.

## Testing Guidelines
- Tests live under `test/` and use Minitest; system tests use Capybara + Selenium.
- Naming: `*_test.rb` in the matching folder (e.g., `test/controllers/users_controller_test.rb`).
- Run focused tests with `bin/rails test test/path/to/file_test.rb`.
- No explicit coverage threshold is defined; keep new behavior covered.

## Commit & Pull Request Guidelines
- Commit messages are short and lowercase without scopes (e.g., `pnpm upgrade`, `gem upgrade`).
- PRs should include a clear description, linked issues, and screenshots for UI changes.
- Ensure CI aligns with local checks: `bundle exec standardrb`, `bin/rails test`, and `bin/rails test:system`.

## Configuration & Development Notes
- Secrets belong in Rails credentials (`bin/rails credentials:edit`), not in `config/settings/*`.
- For SCSS debugging, enable HMR in `config/shakapacker.yml` by setting `hmr: true`.
- Keep Stimulus included in packs to avoid Webpack 5 load-order issues.
