const { globalMutableWebpackConfig: webpackConfig, merge } = require('shakapacker')

// See the shakacode/shakapacker README and docs directory for advice on customizing your webpackConfig.
const customConfig = {
  resolve: {
    extensions: ['.scss']
  }
}

module.exports = merge(webpackConfig, customConfig)
