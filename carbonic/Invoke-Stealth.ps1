﻿#================================#
#  Invoke-Stealth by @JoelGMSec  #
#      https://darkbyte.net      #
#================================#

# Variables
$ErrorActionPreference = "SilentlyContinue"
$InvokePath = $args[0]
$Paramt = $args[1]
$Technique = $args[2]
$NoBanner = $args[3]

# Banner
function Show-Banner {
Write-Host
Write-host "  ___                 _             ____  _             _ _   _      " -ForegroundColor Blue
Write-host " |_ _|_ _ __   _ ___ | | _ ___     / ___|| |_ ___  __ _| | |_| |__   " -ForegroundColor Blue
Write-host "  | || '_ \ \ / / _ \| |/ / _ \____\___ \| __/ _ \/ _' | | __| '_ \  " -ForegroundColor Blue
Write-host "  | || | | \ V / (_) |   <  __/_____|__) | ||  __/ (_| | | |_| | | | " -ForegroundColor Blue
Write-host " |___|_| |_|\_/ \___/|_|\_\___|    |____/ \__\___|\__,_|_|\__|_| |_| " -ForegroundColor Blue
Write-host
Write-host "  ------------------------- by @JoelGMSec -------------------------  " -ForegroundColor Green
Write-host }

# Help
function Show-Help {
Write-host ; Write-Host " Info: " -ForegroundColor Yellow -NoNewLine ; Write-Host " This tool helps you to automate the obfuscation process of"
Write-Host "        any script written in PowerShell with different techniques"
Write-Host ; Write-Host " Usage: " -ForegroundColor Yellow -NoNewLine ; Write-Host ".\Invoke-Stealth.ps1 script.ps1 -technique Chameleon" -ForegroundColor Blue 
Write-Host "         - You can use as single or separated by commas -" ; Write-Host ; Write-Host " Techniques: " -ForegroundColor Yellow 
Write-Host "       · " -NoNewLine ; Write-Host "Chameleon: "-ForegroundColor Green -NoNewLine ; Write-Host "Substitute strings and concatenate variables"
Write-Host "       · " -NoNewLine ; Write-Host "BetterXencrypt: "-ForegroundColor Green -NoNewLine ; Write-Host "Compresses and encrypts with random iterations"
Write-Host "       · " -NoNewLine ; Write-Host "PyFuscation: "-ForegroundColor Green -NoNewLine ; Write-Host "Obfuscate functions, variables and parameters"
Write-Host "       · " -NoNewLine ; Write-Host "ReverseB64: "-ForegroundColor Green -NoNewLine ; Write-Host "Encode with base64 and reverse it to avoid detections"
Write-Host "       · " -NoNewLine ; Write-Host "PSObfuscation: "-ForegroundColor Green -NoNewLine ; Write-Host "Convert content to bytes and compress with Gzip"
Write-Host "       · " -NoNewLine ; Write-Host "All: "-ForegroundColor Green -NoNewLine ; Write-Host "Sequentially executes all techniques described above"
Write-Host ; Write-Host " Warning: " -ForegroundColor Red -NoNewLine  ; Write-Host "The output script will exponentially multiply the original size"
Write-Host "         " -NoNewLine ; Write-Host " Chameleon & PyFuscation need dependencies to work properly" ; Write-Host }

if($NoBanner -notlike '*-nobanner') { Show-Banner } ; if($InvokePath -like '*-h*') { Show-Help ; break }
if(!$Technique) { Show-Help ; Write-Host "[!] Error: Not enough parameters!" -ForegroundColor Red ; Write-Host ; break }

# Checks
$CheckPath = Get-ChildItem $pwd\Resources ; $RandomNumber = Get-Random (10..25)
if ($CheckPath){ $local = "True" ; Get-ChildItem -Path $pwd -Recurse | Unblock-File }
if (($InvokePath -notlike "*/*") -and ($InvokePath -notlike "*\*")){ $InvokePath = "`"$pwd/$($args[0])`"" }

# Functions
function Test-Command { Param ($command)
$oldPreference = $ErrorActionPreference ; $ErrorActionPreference = 'stop'
try { if(Get-Command $command){RETURN $true }}
Catch { RETURN $false } ; Finally { $ErrorActionPreference=$oldPreference }}

function Load-Chameleon {
$TestChameleon = Test-Command python3 ; if ($TestChameleon -in 'True'){ 
Write-Host "[+] Loading Chameleon and doing some obfuscation.. " -ForegroundColor Blue -NoNewline
$Chameleon = python3 ./Resources/Chameleon/chameleon.py -a $InvokePath -o $InvokePath 2>&1> $null
Write-Host "[OK]" -ForegroundColor Green ; Write-Host ; del function_mapping.json -ErrorAction SilentlyContinue }}

function Load-BetterXencrypt {
if($NoBanner -like '*-nobanner') { Write-Host } else {
if($Technique -in 'All') { Write-Host "[!] Avoid mixing BetterXencrypt with another techniques.. " -ForegroundColor Red -NoNewline }
else { Write-Host "[+] Loading BetterXencrypt and doing some encryption with random iterations.. " -ForegroundColor Blue -NoNewline
if ($local){ Import-Module $pwd\Resources\BetterXencrypt\BetterXencrypt.ps1 -Force } else {
(New-object System.net.webclient).DownloadFile("https://raw.githubusercontent.com/JoelGMSec/Invoke-Stealth/main/Resources/BetterXencrypt/BetterXencrypt.ps1","$pwd/BetterXencrypt.ps1")
Import-Module $pwd\BetterXencrypt.ps1 -Force } ; Invoke-BetterXencrypt -InFile $InvokePath -OutFile $InvokePath -Iterations $RandomNumber 2>&1> $null }
Write-Host "[OK]" -ForegroundColor Green ; Write-Host ; del BetterXencrypt.ps1 -ErrorAction SilentlyContinue }}

function Load-PyFuscation {
$TestPyFuscation = Test-Command python3 ; if ($TestPyFuscation -in 'True'){ 
if($Technique -like '*Chameleon*' -or '*all*') { $some = 'more' } else { $some = 'some' }
Write-Host "[+] Loading PyFuscation and doing $some obfuscation.. " -ForegroundColor Blue -NoNewline
$PyExecution = python3 ./Resources/PyFuscation/PyFuscation.py -fvp --ps $InvokePath 2> $null ; if($PyExecution) {
$PyFuscation = "$pwd/Resources/PyFuscation/tmp/script.ps1" ; Clear-Content $InvokePath ; Add-Content $InvokePath $(Get-Content $PyFuscation -ErrorAction SilentlyContinue)}
Write-Host "[OK]" -ForegroundColor Green ; Write-Host ; del "$pwd/Resources/PyFuscation/tmp" -R -Force -ErrorAction SilentlyContinue }}

function Rev64-Encoder {
Write-Host "[+] Encoding with base64 and reverse it to avoid detections.. " -ForegroundColor Blue -NoNewline
$base64 = [Convert]::ToBase64String([IO.File]::ReadAllBytes($InvokePath)) ; $b64 = "`"$base64`""
$base64rev = $b64.ToCharArray() ; [array]::Reverse($base64rev) ; $best64 = -join $base64rev | out-file $InvokePath
$content = Get-Content $InvokePath ; Clear-Content $InvokePath ; Add-Content $InvokePath '$best64code = ' -NoNewline ; Add-Content $InvokePath "$content ;"
Add-Content $InvokePath '$base64 = $best64code.ToCharArray() ; [array]::Reverse($base64) ; -join $base64 2>&1> $null ;'
$RandomCode = '$LoadCode = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("$base64")) ;'
$RandomCode = ($RandomCode -split "" | %{if(@(0..1) | Get-Random){$_.toUpper()}else{$_.toLower()}}) -join "" ; Add-Content $InvokePath $RandomCode
$RandomIEX = (("iN"+"voK"+"e"+"-"+"eXP"+"re"+"sSi"+"oN" -split "(.{$(Get-Random(1..3))})" -ne "" | % { '"' + $_ + '"' + "+" }) -join "").toString().trimend("+")
$RandomCode = '$pwn = ' + $RandomIEX + ' ; New-Alias -name pwn -Value $pwn -Force ; pwn $LoadCode ;'
$RandomCode = ($RandomCode -split "" | %{if(@(0..1) | Get-Random){$_.toUpper()}else{$_.toLower()}}) -join "" ; Add-Content $InvokePath $RandomCode
Write-Host "[OK]" -ForegroundColor Green ; Write-Host }

function Load-PSObfuscation {
Write-Host "[+] Loading PSObfuscation and randomizing script.. " -ForegroundColor Blue -NoNewline
if ($local){ Import-Module $pwd\Resources\PSObfuscation\Invoke-PSObfuscation.ps1 -Force } else {
Invoke-Expression (New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/JoelGMSec/Invoke-Stealth/master/Resources/PSObfuscation/Invoke-PSObfuscation.ps1')}
$PSobfuscation = Invoke-PSObfuscation -Path $InvokePath -Comments -Variables -OutFile $InvokePath
Write-Host "[OK]" -ForegroundColor Green ; Write-Host }

# Main
if($Technique -like '*Chameleon*') { Load-Chameleon }
if($Technique -like '*BetterXencrypt*') { Load-BetterXencrypt }
if($Technique -like '*PyFuscation*') { Load-PyFuscation }
if($Technique -like '*ReverseB64*') { Rev64-Encoder }
if($Technique -like '*PSObfuscation*') { Load-PSObfuscation }

if($Technique -in 'All') { Load-Chameleon ; Load-BetterXencrypt ; Load-PyFuscation ; Rev64-Encoder ; Load-PSObfuscation }
if($NoBanner -notlike '*-nobanner') { Write-Host "[+] Done! " -ForegroundColor Green ; Write-Host }
