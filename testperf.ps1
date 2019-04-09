param ([int]$TestCount = 0,
[string]$Version)
Import-Module 'UnitySetup'
'Version Tested: ' + $Version | Out-File .\results.txt

$results = @() 

for ($i = 0; $i -lt $TestCount; $i++) {
    'Test'+$i | Out-File .\results.txt -Append
    $result = Measure-Command {Start-UnityEditor -BatchMode -Version $Version -Quit -CreateProject Test -LogFile test.log -Wait}
    $result | Out-File .\results.txt -Append
    $results += $result
    Remove-Item -Path .\Test -Recurse -Force
    Remove-Item -Path .\test.log -Force
} 

$totalResults = $results | Measure-Object -Property "TotalMinutes" -Average -Sum -Maximum -Minimum 
$totalResults | Out-File .\results.txt -Append


