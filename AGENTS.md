# Repository Guidelines

## Project Structure & Module Organization
Core Rails app lives in `app/`, with controllers, models, policies, and component views aligned by feature. Stimulus controllers, entrypoints, and styles compile through Shakapacker under `app/javascript` (`packs/` for entry bundles, `controllers/` for Stimulus files named `*_controller.js`). Shared utilities stay in `lib/`, while background configuration and initializers live in `config/`. Tests are organized in `test/` following Rails defaults (`test/controllers`, `test/system`, etc.). Environment-specific settings rely on the Config gem in `config/settings/*.yml`; prefer overriding via `ENV` rather than editing production files.

## Build, Test, and Development Commands
- `bin/setup` installs gems, yarn packages, and prepares the database.
- `bin/rails server` starts the Rails app; pair with `bin/shakapacker-dev-server` for live asset recompilation.
- `bin/rails db:migrate` applies schema changes; use `bin/rails db:rollback STEP=1` to undo.
- `bin/shakapacker` builds production assets.
- `bin/brakeman` runs the security scan prior to release.

## Coding Style & Naming Conventions
Ruby code follows StandardRB (two-space indentation, double quotes preferred). Run `bundle exec standardrb --fix` before committing; the project’s `.rubocop.yml` loads this configuration. Stimulus controllers should be camel-cased classes in files like `app/javascript/controllers/users_controller.js`. SCSS modules under `app/javascript/stylesheets` should mirror the related pack name (e.g., `dashboard.scss`). Use snake_case for database columns and method names, and keep migrations reversible.

## Testing Guidelines
Rails ships with Minitest; run suites via `bin/rails test` and system specs with `bin/rails test:system`. For targeted debugging use `bin/rails test TEST=test/controllers/accounts_controller_test.rb`. Feature work should include system tests when UI changes are involved and policy tests when touching authorization. Keep fixtures under `test/fixtures` lean and create factory helpers in `test/support` when scenarios repeat.

## Commit & Pull Request Guidelines
Make commits concise and imperative, mirroring the existing history (`yarn upgrade`, `gem upgrade`). Every pull request should describe the change, reference issues (e.g., `Fixes #123`), and note any migrations. Attach UI screenshots or console output when behavior changes. Verify `bin/rails test` and `bundle exec standardrb --fix` locally before requesting review.

## Security & Configuration Tips
Store secrets via `bin/rails credentials:edit`; never commit raw keys to `config/settings`. Keep default admin or sample data out of production branches. Run `bin/brakeman` and review warnings before deployment, and ensure new endpoints enforce Pundit policies.
