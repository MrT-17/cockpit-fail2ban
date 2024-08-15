/**
 * @type {import('semantic-release').GlobalConfig}
 */

module.exports = {
  branches: ['master'],
  plugins: [
    [
      '@semantic-release/commit-analyzer',
      {
        preset: 'angular'
      }
    ],
    '@semantic-release/release-notes-generator',
    '@semantic-release/changelog',
    '@semantic-release/npm',
    [
      '@semantic-release/exec',
      {
        prepareCmd: 'node update-manifest-version.ts ${nextRelease.version}'
      }
    ],
    [
      '@semantic-release/git',
      {
        assets: ['package.json', 'src/manifest.json', 'CHANGELOG.md'],
        message: 'chore(release): ${nextRelease.version} [skip ci]'
      }
    ]
  ]
};
