# Define the source folder
$sourceFolder = "C:\Users\Duder5000\Desktop\rf"

# Define the destination folders
$trainFolder = "C:\Users\Duder5000\Desktop\train"
$valFolder = "C:\Users\Duder5000\Desktop\val"

# Get the list of folders in the source folder
$folders = Get-ChildItem -Path $sourceFolder -Directory

# Loop through each folder and create new folders in both train and val folders
foreach ($folder in $folders) {
    # Get the name of the folder
    $folderName = $folder.Name
    
    # Create folders in the train and val directories
    New-Item -ItemType Directory -Path (Join-Path -Path $trainFolder -ChildPath $folderName) -Force
    New-Item -ItemType Directory -Path (Join-Path -Path $valFolder -ChildPath $folderName) -Force
}