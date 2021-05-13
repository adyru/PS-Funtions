Function test-server{
        <#
        .Description
        test-server server port
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
            # Check DNS and just keep the first one
            $lookups= $null
            $Lookups = (Resolve-DnsName $servertest -DnsOnly -ErrorAction Stop).IP4Address
            $DNSCheck = $Lookups| select -First 1
            }
        #Catch the error in the DNS record doesnt exist
        catch [System.ComponentModel.Win32Exception] 
            {Write-host -ForegroundColor red $servertest " was not found"}
    
        Finally
            {
            # Null out array
            $global:CheckConnection = $null
             If ([STRING]::IsNullOrWhitespace($DNSCheck))
                {
                }
            Else
                {
                # If it is a numerical port do a check
                if($porttest -match "^\d{1,3}")
                    {
                    $global:CheckConnection = Test-NetConnection $DNSCheck -port $Porttest -WarningAction SilentlyContinue
                    }
                # If it is a well know  port do a check
                ElseIf($porttest -eq "SMB" -or $porttest -eq "RDP" -or $porttest -eq "HTTP" -or $porttest -eq "WINRM")
                    {
                    $global:CheckConnection = Test-NetConnection $DNSCheck    $Porttest -WarningAction SilentlyContinue
                    }
                # if it is neither write error to screen
                Else
                    {
                    write-host -ForegroundColor Red "You have entered and incorrect port $($porttest) - it needs to either be a number of one of HTTP,RDP,SMB,WINRM"
                    }
                }
            }

}
