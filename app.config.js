const { withGradleProperties } = require('@expo/config-plugins');

/**
 * Expo SDK 54+ prebuild injects edgeToEdgeEnabled=true into android/gradle.properties
 * even when app.json omits android.edgeToEdgeEnabled. That interacts badly with
 * expo-status-bar → react-native-is-edge-to-edge on some setups (red screen / runtime not ready).
 * Force native edge-to-edge flags off so Gradle matches a non-edge-to-edge app config.
 */
function withAndroidEdgeToEdgeGradleOff(config) {
  return withGradleProperties(config, (cfg) => {
    const items = cfg.modResults;
    const upsert = (key, value) => {
      const row = { type: 'property', key, value };
      const i = items.findIndex((p) => p.type === 'property' && p.key === key);
      if (i >= 0) items[i] = row;
      else items.push(row);
    };
    upsert('edgeToEdgeEnabled', 'false');
    upsert('expo.edgeToEdgeEnabled', 'false');
    return cfg;
  });
}

module.exports = ({ config }) => ({
  ...config,
  plugins: ['expo-asset', ...(config.plugins || []), withAndroidEdgeToEdgeGradleOff],
});
