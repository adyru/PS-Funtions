Function Add-Attachments {
     [CmdletBinding()]
        
        Param(
        [Parameter(Mandatory=$true)]
        [string]
        $File
        )

        $Check = test-path $file
        If($Check -eq $true)
            {
            $script:attachments += $file
            }
        Else
            {
            write-host -ForegroundColor red "File $($attachments) doesnt exist"
            }

}
$attachments = @()
