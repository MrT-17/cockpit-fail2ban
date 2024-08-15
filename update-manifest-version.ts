import fs from 'fs';
import path from 'path';

const version = process.argv[2];

const manifestPath = path.join(__dirname, 'src', 'manifest.json');
const manifest = require(manifestPath);

manifest.version = version;

fs.writeFileSync(manifestPath, JSON.stringify(manifest, null, 2));

console.log(`Updated manifest.json version to ${version}`);
