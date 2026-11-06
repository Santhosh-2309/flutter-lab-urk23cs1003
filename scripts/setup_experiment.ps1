# Usage: scripts\setup_experiment.ps1 <1-7>
param([Parameter(Mandatory=$true)][int]$N)
Set-Location (Join-Path $PSScriptRoot "..\experiment_$N")
$plat = @()
if ($N -eq 11) { $plat = @("--platforms=ios,web,windows") }
flutter create @plat --project-name "experiment_$N" .
if ($N -eq 11 -and (Test-Path "ios\Runner\Info.plist")) {
  $p = Get-Content "ios\Runner\Info.plist" -Raw
  $p = $p -replace '(?s)(<key>CFBundleDisplayName</key>\s*<string>)[^<]*', '${1}Santhosh V Flutter App'
  Set-Content "ios\Runner\Info.plist" $p -NoNewline
}
flutter pub get
Write-Host "Ready. Run: cd experiment_$N; flutter run -d chrome"
