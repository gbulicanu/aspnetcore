param(
    [switch]$ci
)
$ErrorActionPreference = 'stop'

$Configuration = if ($ci) { 'Release' } else { 'Debug' }
$repoRoot = Resolve-Path "$PSScriptRoot/../.."
$MsbuildEngine = 'dotnet'

& "$repoRoot\eng\common\msbuild.ps1" -ci:$ci "$repoRoot/eng/CodeGen.proj" `
    -configuration $Configuration `
    -msbuildEngine $MsbuildEngine `
    /t:GenerateProjectList `
    /bl:artifacts/log/genprojlist.binlog
