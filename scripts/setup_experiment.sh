#!/usr/bin/env bash
# Usage: scripts/setup_experiment.sh <1-7>
set -e
N="$1"; [ -z "$N" ] && { echo "usage: $0 <1-7>"; exit 1; }
cd "$(dirname "$0")/../experiment_$N"
PLAT=""; [ "$N" = "11" ] && PLAT="--platforms=ios,web,windows"
flutter create $PLAT --project-name "experiment_$N" .
if [ "$N" = "11" ] && [ -f ios/Runner/Info.plist ]; then
  perl -0pi -e 's|(<key>CFBundleDisplayName</key>\s*<string>)[^<]*|${1}Santhosh V Flutter App|' ios/Runner/Info.plist
fi
flutter pub get
echo "Ready. Run: cd experiment_$N && flutter run -d chrome"
