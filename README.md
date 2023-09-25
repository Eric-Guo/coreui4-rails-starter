# The CoreUI 4 Rails Starter Template

[![Build Status](https://github.com/Eric-Guo/coreui4-rails-starter/actions/workflows/rubyonrails.yml/badge.svg)](https://github.com/Eric-Guo/coreui4-rails-starter/actions)

## Development notes

### When you want to debug the SCSS

Set `shakapacker.yml` hmr to true.

```yml
hmr: true
```

### Why should always include "stimulus"

Because using webpack 5, the loading sequence do matter.

### How to debug in VSCode?

Install `Ruby LSP` by Shopify and `VSCode rdbg Ruby Debugger` by KoichiSasada.

Make sure debug only having one version install as default gems, otherwise uninstall first:

```bash
gem uninstall -i /opt/homebrew/Cellar/ruby/3.2.2/lib/ruby/gems/3.2.0 debug
gem install debug --default
```
