#!/usr/bin/env sh
# Lightweight Gradle bootstrapper. Downloads the pinned Gradle distribution when needed.
set -eu
APP_HOME=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
GRADLE_VERSION="9.3.1"
GRADLE_HOME_DIR="${GRADLE_USER_HOME:-$HOME/.gradle}/quitnow-gradle/gradle-${GRADLE_VERSION}"
GRADLE_BIN="$GRADLE_HOME_DIR/bin/gradle"
if [ ! -x "$GRADLE_BIN" ]; then
  mkdir -p "$(dirname "$GRADLE_HOME_DIR")"
  ZIP="$(dirname "$GRADLE_HOME_DIR")/gradle-${GRADLE_VERSION}-bin.zip"
  URL="https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip"
  echo "Downloading Gradle ${GRADLE_VERSION}..."
  if command -v curl >/dev/null 2>&1; then curl -fL "$URL" -o "$ZIP"
  elif command -v wget >/dev/null 2>&1; then wget -O "$ZIP" "$URL"
  else echo "Install curl or wget, then rerun." >&2; exit 1; fi
  unzip -q -o "$ZIP" -d "$(dirname "$GRADLE_HOME_DIR")"
fi
exec "$GRADLE_BIN" -p "$APP_HOME" "$@"
