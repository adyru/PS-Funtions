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
                if($port -match "^\d{1,3}")
                    {
                    $global:CheckConnection = Test-NetConnection $servertest -port $Porttest
                    }
                Else
                    {
                    $global:CheckConnection = Test-NetConnection $servertest  $Porttest
                    }
                }
            }

}

