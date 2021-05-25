

Function Write-Log {
    <#
        . Notes
        =======================================
        v1  Created on: 25/05/2021
            Created by AU             
        =======================================
        . Description
        Params are Level and Message - it will use these as the output along with the date 
        Depending on how $OutputScreenInfo and  $OutputScreenNotInfo are set it will also output to screen
        You need to define the output file  $logfile  in the main script block
                write-log -level info -message "Something"

        #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $False)]
        [ValidateSet("INFO", "WARN", "ERROR", "FATAL", "DEBUG")]
        [String]
        $Level = "INFO",

        [Parameter(Mandatory = $True)]
        [string]
        $Message
    
    )
    # Check if we have a logfile defined and quit script if not with error to screen
    If (!($logfile)) {
        write-host -foregroundcolor red "Logfile not defind so exiting - create a variable called $logfile  and try again"
        exit

    }
    # Set these to $true or $false - switches on and off output to screen
    # One if for info eventss the other for anything but info
    $OutputScreenInfo = $false
    $OutputScreenNotInfo = $true
    $Stamp = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
    # Create the line from the timestamp, level and message
    $Line = "$Stamp $Level $Message"
    # Create seperate log file for errors
    $ErrorLog = $logfile -replace ".txt", "-errors.txt"
    #write-host "Output is $($outputscreen)"
    # Check if the level isnt info and then write to error log
    If ($level -ne "info") {
        Add-Content $ErrorLog  -Value $Line
        # Check if we want this outputted to screen, if so it is unexpected so error to screen
        If ($OutputScreenNotInfo -eq $true) {
            write-host -ForegroundColor Red $Message 
        }
    }
    # Write to log for info events
    Else {
        Add-Content $logfile -Value $Line
        # And if required output these to screen
        If ($OutputScreenInfo -eq $true) {
            write-host  $Message 
        }
    }

}
#$logfile = $null
$logFile = "delete.txt"
Write-Log  -Message "testing again 123" -Level "Info"
Write-Log  -Message "test and some more tezt 123" -Level "Error"
