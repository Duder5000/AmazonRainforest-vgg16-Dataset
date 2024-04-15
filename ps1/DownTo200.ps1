# Define the path to the main folder
$mainFolderPath = "C:\Users\Duder5000\Desktop\train"

# Get all subfolders
$subfolders = Get-ChildItem -Path $mainFolderPath -Directory

# Loop through each subfolder
foreach ($subfolder in $subfolders) {
    # Get all files in the current subfolder
    $files = Get-ChildItem -Path $subfolder.FullName -File
    
    # Check if the number of files is greater than 200
    if ($files.Count -gt 200) {
        # Calculate the number of files to delete
        $filesToDeleteCount = $files.Count - 200
        
        # Shuffle the files randomly
        $shuffledFiles = $files | Get-Random -Count $files.Count
        
        # Select the files to delete
        $filesToDelete = $shuffledFiles[0..($filesToDeleteCount - 1)]
        
        # Delete the selected files
        foreach ($fileToDelete in $filesToDelete) {
            Remove-Item -Path $fileToDelete.FullName -Force
            Write-Output "Deleted file: $($fileToDelete.FullName)"
        }
    }
}