function setupCatiaSettings {
  $catiaEnvPath = Join-Path $PSScriptRoot "catia"

  # Brute-force copy the CATSettings that needs to be set with settings
  # files (e.g. licensing and tree visualization)
  $catSettingsPath = Join-Path $catiaEnvPath "CATSettings"
  $userCatSettingsPath = Join-Path $env:APPDATA "DassaultSystemes/CATSettings"
  New-Item -Force -Type Directory -Path $userCatSettingsPath
  Copy-Item -Path $catSettingsPath/* -Destination $userCatSettingsPath -Recurse -Force

  # Set the other settings via CATScript
  Invoke-Item (Join-Path $catiaEnvPath "setup.CATScript")
}

function setupExcelTrust {
  # Enable access to the VBA object model
  New-ItemProperty -Path "Registry::HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Excel\Security\" -Name "AccessVBOM" -PropertyType "DWord" -Value 1 -Force
  # Enable all macros
  New-ItemProperty -Path "Registry::HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Excel\Security\" -Name "VBAWarnings" -PropertyType "DWord" -Value 1 -Force
}

Write-Host -ForegroundColor Blue "Setting up Excel trust center..."
setupExcelTrust | Out-Null

Write-Host -ForegroundColor Blue "Setting up CATIA license and settings..."
setupCatiaSettings | Out-Null
