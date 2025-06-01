# schedule.ps1

$taskNameBase = "Download GTFS"
$scriptPath = (Resolve-Path ".\download-gtfs.ps1").Path

# Define trigger times
$times = @("10:00AM", "2:00PM", "6:00PM")

# Loop through each time and create a scheduled task
foreach ($time in $times) {
    $formattedTime = (Get-Date $time).ToString("HHmm")
    $taskName = "$taskNameBase-$formattedTime"

    # Create a new trigger
    $trigger = New-ScheduledTaskTrigger -Weekly -DaysOfWeek Friday -At $time

    # Create action to run PowerShell with your script
    $action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -ExecutionPolicy Bypass -File `"$scriptPath`""

    # Register the task
    Register-ScheduledTask -TaskName $taskName -Trigger $trigger -Action $action -Description "Download GTFS data on Fridays at $time" -User "SYSTEM" -RunLevel Highest -Force
}

Write-Host "Scheduled tasks created successfully."