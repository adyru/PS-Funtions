Function Nettest-server{
        <#
        .Description
        test-server server port.Params are server and port - accepts either common ports or numbers
        it then trys to resolve the DNS name and catches the error if cant 
        if it succeeds it goes on to test the connection to a port 
        returns values back to script block in $tcpclient -  Timeout for connection is $Timer in MS
        #>
     [CmdletBinding()]

        Param(
        [Parameter(Mandatory=$True)]
        [string]
        $servertest,

        [Parameter(Mandatory=$True)]
        [string]
        $Porttest
        )
        try
            {
            # Check DNS and just keep the first one
            $lookups= $null
            $Lookups = (Resolve-DnsName $servertest -DnsOnly -ErrorAction Stop).IP4Address
            $DNSCheck = $Lookups| select -First 1
            }
        #Catch the error in the DNS record doesnt exist
        catch [System.ComponentModel.Win32Exception] 
            {Write-host -ForegroundColor red $servertest " was not found"}
    
            # Null out array
             If ([STRING]::IsNullOrWhitespace($DNSCheck))
                {
                }
            Else
                {
                # If it is a numerical port do a check
                if($porttest -match "^\d{1,3}")
                    {
                     try {
                        $tcpclient  = New-Object System.Net.Sockets.TCPClient
                        $Timer=1500
                        $StartConnection = $tcpclient.BeginConnect($servertest,$PortTest,$null,$null)
                        $wait = $StartConnection.AsyncWaitHandle.WaitOne($timer,$false)
                        return  Write-Output -NoEnumerate  $tcpclient
                        }

                    catch {
                           return  Write-Output -NoEnumerate  $tcpclient
                          }
                    }
                    
                Else
                    {
                    write-host -ForegroundColor Red "You have entered and incorrect port $($porttest) - it needs to either be a number"
                    }
                }
            }


$a = Nettest-server google.com 444
$a
