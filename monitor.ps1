$folder = "C:\Users\Coly\Desktop\Adguard Unified"
$filter = "*.txt"

$fsw = New-Object IO.FileSystemWatcher $folder, $filter
$fsw.IncludeSubdirectories = $false
$fsw.EnableRaisingEvents = $true

$action = {
    $path = $Event.SourceEventArgs.FullPath
    $changeType = $Event.SourceEventArgs.ChangeType
    Write-Host "File modification detected ($changeType) for $path at $(Get-Date)"
    
    # Run Git commands automatically
    cd $folder
    git add .
    git commit -m "Automated real-time update to AdGuard ruleset"
    git push origin main
}

# Listen for both modifications AND new file creations
Register-ObjectEvent $fsw "Changed" -Action $action
Register-ObjectEvent $fsw "Created" -Action $action

while ($true) { Start-Sleep 5 }