#!/bin/bash
set -euo pipefail

# Only run in Claude Code remote environments
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(cd "$(dirname "$0")/../../.." && pwd)}"
CARRUSEL_DIR="$PROJECT_DIR/open-carrusel"

if [ ! -d "$CARRUSEL_DIR" ]; then
  echo "open-carrusel directory not found at $CARRUSEL_DIR, skipping setup."
  exit 0
fi

cd "$CARRUSEL_DIR"

echo "Installing open-carrusel dependencies..."
npm install

echo "Seeding data directories..."
OC_SETUP_NO_DEV=1 node scripts/setup.mjs

echo "open-carrusel setup complete."
