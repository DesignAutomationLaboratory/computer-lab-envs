function setupExcelTrust {
  New-ItemProperty -Path "Registry::HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Excel\Security\" -Name "AccessVBOM" -PropertyType "DWord" -Value 1 -Force
  New-ItemProperty -Path "Registry::HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Excel\Security\" -Name "VBAWarnings" -PropertyType "DWord" -Value 1 -Force
}

Write-Host -ForegroundColor Blue "Setting up Excel trust center..."
setupExcelTrust | Out-Null
