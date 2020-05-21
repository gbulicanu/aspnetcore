param(
    [switch]$ci
)
$ErrorActionPreference = 'stop'

$repoRoot = Resolve-Path "$PSScriptRoot/../.."

$Configuration = if ($ci) { 'Release' } else { 'Debug' }
& "$repoRoot\build.ps1" -ci:$ci -buildNative -configuration $Configuration

$MsbuildEngine = 'dotnet'
& "$repoRoot\eng\common\msbuild.ps1" -ci:$ci "$repoRoot/eng/CodeGen.proj" `
    -configuration $Configuration `
    -msbuildEngine $MsbuildEngine `
    /t:GenerateReferenceSources `
    /bl:artifacts/log/genrefassemblies.binlog
