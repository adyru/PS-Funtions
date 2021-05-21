Function Export-File {
            <#
        . Notes
        =======================================
        v1  Created on: 13/05/2021
            Created by AU  
        V2 - 21/05/2021 Added in Check so that if files exists it exports with a random digit inserted           
        =======================================
        . Description
        Params are variable and filename 
        it then exports the variable to a csv if it isnt null
        If files exists adds in some random digits to makes sure there is an export
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
                # if the files exists we will use  a random number into the filename 
                write-host -ForegroundColor Red "$($outfile) already exists"

                If (!($OutVar))
                    {
                    write-host "Variable is null"
                    return;
                    }
                Else
                    {
                    $Random = Get-Random -Minimum 1 -Maximum 100
                    $newOut =  $outfile -replace ".csv","$($Random).csv"
                    $OutVar | Export-Csv -NoClobber -NoTypeInformation -path $newout
                    $OutcheckFile = test-path $outfile
                    If($OutcheckFile -eq $true)
                        {write-host -ForegroundColor Green "Variable exported to $($newout)"}
                    Else
                        {write-host -ForegroundColor red "Variable not exported to $($newout)"}
                    }
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

$a = "a"
$aout = "filewe3wewqeq.csv"
Export-File $a $aout
