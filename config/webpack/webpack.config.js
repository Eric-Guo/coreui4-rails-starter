const path = require('path');
const { generateWebpackConfig, merge } = require('shakapacker');

const webpackConfig = generateWebpackConfig();

if (!webpackConfig) {
  throw new Error('generateWebpackConfig did not return a valid configuration. Check your Shakapacker setup.');
}

// Shakapacker 10 uses Sass's modern API, which resolves load paths explicitly.
webpackConfig.module.rules.forEach((rule) => {
  if (!Array.isArray(rule.use)) return;

  rule.use.forEach((loader) => {
    if (!loader.loader?.includes('sass-loader')) return;

    loader.options.sassOptions.loadPaths = [
      path.resolve(__dirname, '../../app/javascript'),
      path.resolve(__dirname, '../../node_modules')
    ];
    delete loader.options.sassOptions.includePaths;
  });
});

// See the shakacode/shakapacker README and docs directory for advice on customizing your webpackConfig.
const customConfig = {
  resolve: {
    extensions: ['.scss']
  }
};

if (process.env.NODE_ENV === 'development') {
  // Rails reads entrypoints from public/packs/manifest.json even while the
  // webpack dev server serves the actual bundles from memory. Keep that one
  // file in sync so every dev-server-only chunk is included by the helpers.
  customConfig.devServer = {
    devMiddleware: {
      writeToDisk: (filePath) => filePath.endsWith('manifest.json')
    }
  };
}

module.exports = merge(webpackConfig, customConfig);
