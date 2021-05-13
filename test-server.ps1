Function test-server{
        <#
        .Description
        Params are server and port - accepts either common ports or numbers
        it then trys to resolve the DNS name and catches the error if cant 
        if it succeeds it goes on to test the connection to a port 
        returns values back to script block in $CheckConnection
        #>
     [CmdletBinding()]

        Param(
        [Parameter(Mandatory=$True)]
        [string]
        $global:servertest,

        [Parameter(Mandatory=$True)]
        [string]
        $global:Porttest
        )
        try
            {
            $lookups= $null
            $Lookups = Resolve-DnsName $servertest -DnsOnly -ErrorAction Stop
            }
   
        catch [System.ComponentModel.Win32Exception] 
            {Write-host -ForegroundColor red $servertest " was not found"}
    
        Finally
            {
            $global:CheckConnection = $null
             If ([STRING]::IsNullOrWhitespace($Lookups.Name))
                {
                }
            Else
                {
                if($porttest -match "^\d{1,3}")
                    {
                    $global:CheckConnection = Test-NetConnection $servertest -port $Porttest
                    }
                ElseIf($porttest -eq "SMB" -or $porttest -eq "RDP" -or $porttest -eq "HTTP" -or $porttest -eq "WINRM")
                    {
                    write-host "here"
                    $porttest
                    $global:CheckConnection = Test-NetConnection $servertest  $Porttest
                    }
                Else
                    {
                    write-host -ForegroundColor Red "You have entered and incorrect port - it needs to either be a number of one of HTTP,RDP,SMB,WINRM"
                    }
                }
            }

}



#test-server google.com1 443
#write-host "the connection to $($servertest) on $($porttest) is$($CheckConnection.TcpTestSucceeded)"

test-server google.com https
write-host "the connection to $($servertest) on $($porttest) is$($CheckConnection.TcpTestSucceeded)"
$CheckConnection

