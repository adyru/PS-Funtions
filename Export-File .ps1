Function Export-File {
            <#
        . Notes
        =======================================
        v1  Created on: 13/05/2021
            Created by AU             
        =======================================
        . Description
        Params are variable and filename 
        it then exports the variable to a csv if it isnt null
            export-file $var $varout
        #>
     [CmdletBinding()]
        
        Param(
        [Parameter(Mandatory=$false)]
        [Array]
        $OutVar,

        [Parameter(Mandatory=$True)]
        [string]
        $OutFile

        )
        Begin
            {
            $checkFile = test-path $outfile
            }
        Process
            {
            If($checkFile -eq $true)
                {
                write-host -ForegroundColor Red "$($outfile) already exists"
                return;
                }
            Else
                {
                If (!($OutVar))
                    {
                    write-host "Variable is null"
                    return;
                    }
                Else
                    {
                    $OutVar | Export-Csv -NoClobber -NoTypeInformation -path $OutFile
                    $OutcheckFile = test-path $outfile
                    If($OutcheckFile -eq $true)
                        {write-host -ForegroundColor Green "Variable exported to $($OutFile)"}
                    Else
                        {write-host -ForegroundColor red "Variable not exported to $($OutFile)"}
                    }
                }
            
 

    }
        End
           {

           }
}
