const { getDefaultConfig } = require('expo/metro-config');
const path = require('path');

const projectRoot = __dirname;
const workspaceRoot = path.resolve(projectRoot, '..');

const config = getDefaultConfig(projectRoot);

// The example app depends on local workspace packages via `file:..`.
// Metro must be allowed to follow those symlinks + watch folders outside projectRoot.
config.watchFolders = [
  path.resolve(workspaceRoot, 'dengage-react-sdk'),
  path.resolve(workspaceRoot, 'expo-dengage'),
];

config.resolver.unstable_enableSymlinks = true;
config.resolver.disableHierarchicalLookup = true;
config.resolver.nodeModulesPaths = [
  path.resolve(projectRoot, 'node_modules'),
  path.resolve(workspaceRoot, 'node_modules'),
];

module.exports = config;

