# Set the path to the parent directory
$parentDir = "C:\Users\Duder5000\Desktop\rf"

# Get all subfolders within the parent directory
$subfolders = Get-ChildItem -Path $parentDir -Directory

# Iterate through each subfolder
foreach ($subfolder in $subfolders) {
    Write-Host "Processing subfolder $($subfolder.Name)"

    # Create train and val folders within each subfolder
    $trainFolder = Join-Path -Path $subfolder.FullName -ChildPath "train"
    $valFolder = Join-Path -Path $subfolder.FullName -ChildPath "val"
    if (!(Test-Path -Path $trainFolder)) {
        New-Item -ItemType Directory -Path $trainFolder | Out-Null
    }
    if (!(Test-Path -Path $valFolder)) {
        New-Item -ItemType Directory -Path $valFolder | Out-Null
    }

    # Get all files within the subfolder
    $files = Get-ChildItem -Path $subfolder.FullName -File

    # Calculate the number of files for train and val
    $totalFiles = $files.Count
    $trainCount = [math]::Round($totalFiles * 0.7)
    $valCount = $totalFiles - $trainCount

    # Randomly select files for train and val
    $trainFiles = $files | Get-Random -Count $trainCount
    $valFiles = $files | Where-Object { $trainFiles -notcontains $_ } | Get-Random -Count $valCount

    # Move files to train folder
    foreach ($file in $trainFiles) {
        Move-Item -Path $file.FullName -Destination $trainFolder
    }

    # Move files to val folder
    foreach ($file in $valFiles) {
        Move-Item -Path $file.FullName -Destination $valFolder
    }

    Write-Host "Finished processing subfolder $($subfolder.Name)"
}

Write-Host "All folders processed successfully."