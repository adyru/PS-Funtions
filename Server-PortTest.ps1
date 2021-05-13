Function Server-PortTest{
        <#
        . Notes
        =======================================
        v1  Created on: 13/05/2021
            Created by AU             
        =======================================
        . Description
        Params are server and port - it then trys to resolve the DNS name and catches the error if cant 
        If it succeeds it goes on to test the connection to the same server over the requested port
        Returns values back to script block in $tcpclient -  Timeout for connection is $Timer
        example $server  below of how to use this function
                Server-PortTest google.com 443
                $server.Connected
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
        Begin
            {
            #Null the arrays
            $lookups= $null
            try
                {
                # Check DNS and just keep the first one
                $Lookups = (Resolve-DnsName $servertest -DnsOnly -ErrorAction Stop).IP4Address
                $DNSCheck = $Lookups| select -First 1
                }
                #Catch the error in the DNS record doesnt exist
                catch [System.ComponentModel.Win32Exception] 
                    {Write-host -ForegroundColor red $servertest " was not found"}
                }
        Process
            {
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
        End
            {
            return  Write-Output -NoEnumerate  $tcpclient
            }
         }
