function setupCatiaSettings {
  # This is using the brute-force approach of copying the CATSettings. A
  # more elegant approach would be to use the CATIA COM API to do all
  # stuff, but that's a bit hard to do, due to the following reasons:
  # 1. PowerShell and the CATIA COM API don't like each other.
  # 2. I don't know if it is possible to set the license on a cold CATIA
  #    environment.
  # 3. There's no way to set the tree visualization settings via the
  #    API.
  $catEnvPath = $PSScriptRoot + "\catia\CATSettings"
  $userCatEnvPath = $env:APPDATA + "\DassaultSystemes\CATSettings"

  New-Item -Force -Type Directory -Path $userCatEnvPath
  Copy-Item -Path $catEnvPath/* -Destination $userCatEnvPath -Recurse -Force
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
