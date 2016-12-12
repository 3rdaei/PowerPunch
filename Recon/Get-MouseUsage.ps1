function Invoke-CheckMouseInUse {
    <# 
      .SYNOPSIS 
      Queries the computer to see if the mouse has moved.

      Author: Jared Haight (@jaredhaight)
      License: MIT License
      Required Dependencies: None
      Optional Dependencies: None

      .DESCRIPTION 
      This script will run for a period of time, polling for mouse movement at a specified 
      interval. Returns True if the mouse has moved, False if it has not.

      .PARAMETER PollingTime
      How long to poll for movement, specified in seconds. Default is 5 seconds.

      .PARAMETER Frequency
      How often to poll for movement, specfied in seconds. Default is 0 (constant polling)

      .EXAMPLE 
      PS C:\>Invoke-CheckMouseInUse -PollingTime 10 -Frequency 2
 
      Description
      -----------
      Check for mouse usage every 2 seconds over the course of 10 seconds (five checks total).

      .LINK 
      Script source can be found at https://github.com/jaredhaight/PowerPunch/Recon/Invoke-CheckMouseUsage.ps1

    #>
    [cmdletbinding()]
    param(
      [int]$PollingTime=3,
      [int]$Frequency=0
    )
    
    Add-Type -AssemblyName System.Windows.Forms
    $pos = [System.Windows.Forms.Cursor]::Position
    $endTime = (Get-Date).AddSeconds($PollingTime)
    while ((Get-Date) -lt $endTime) {
      $newPos = [System.Windows.Forms.Cursor]::Position
      if (($pos.x -ne $newPos.x) -or ($pos.y -ne $newPos.y)){
        return $true
      }
      Start-Sleep $Frequency
    }
    return $false
}