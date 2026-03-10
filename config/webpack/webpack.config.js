const { generateWebpackConfig, merge } = require('shakapacker');

const webpackConfig = generateWebpackConfig();

if (!webpackConfig) {
  throw new Error('generateWebpackConfig did not return a valid configuration. Check your Shakapacker setup.');
}

const setLegacySassApi = (rules = []) => {
  rules.forEach((rule) => {
    if (Array.isArray(rule.oneOf)) {
      setLegacySassApi(rule.oneOf);
    }

    if (!Array.isArray(rule.use)) {
      return;
    }

    rule.use.forEach((loader) => {
      if (typeof loader === "object" && loader.loader?.includes("sass-loader")) {
        loader.options = { ...loader.options, api: "legacy" };
      }
    });
  });
};

// Shakapacker 9.6 switched sass-loader to the modern Sass API by default.
// This app still depends on package-based Sass imports that resolve correctly
// with the legacy API used before the upgrade.
setLegacySassApi(webpackConfig.module?.rules);

// See the shakacode/shakapacker README and docs directory for advice on customizing your webpackConfig.
const customConfig = {
  resolve: {
    extensions: ['.scss']
  }
};

module.exports = merge(webpackConfig, customConfig);
