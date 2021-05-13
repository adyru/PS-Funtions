Function Export-File {
     [CmdletBinding()]
        
        Param(
        [Parameter(Mandatory=$true)]
        [string]
        $OutVar,

        [Parameter(Mandatory=$True)]
        [string]
        $OutFile
        )

        If ([STRING]::IsNullOrWhitespace($OutVar))
            {write-host "$($OutVar) is null"}
        Else
            {$OutVar | Export-Csv -NoClobber -NoTypeInformation -path $OutFile}

}
