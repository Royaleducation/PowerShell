Install-Module -Name PSScriptAnalyzer

Get-ScriptAnalyzerRule


Invoke-ScriptAnalyzer -Path C:\Users\Geri\Documents\PSScripts\credentialtricks.ps1

## To execute the DSC rules use the following command:
Invoke-ScriptAnalyzer -Path /path/to/module/ -Settings DSC -Recurse

## To execute the code formatting rules use the following command:
Invoke-ScriptAnalyzer -Path /path/to/module/ -Settings CodeFormatting -Recurse

