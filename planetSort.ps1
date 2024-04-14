# Define the path to the CSV file
$csvPath = "F:\GDrive\rainforest\planet\train_classes_new.csv"

# Read the CSV file
$csvData = Import-Csv -Path $csvPath

# Initialize an array to store image names without matching jpg files
$missingImages = @()
$missingImages += "TEST"

# Delete the "MissingImages.txt" file if it exists
#if (Test-Path -Path $missingImagesPath) {
    #Remove-Item -Path $missingImagesPath
#}

# Step 1: Create folders for each unique tag
foreach ($row in $csvData) {
    $tag = $row.tags
    $folderPath = "F:\planetSort1\$tag"

    # Create folder if it doesn't exist
    if (-not (Test-Path -Path $folderPath)) {
        New-Item -ItemType Directory -Path $folderPath | Out-Null
		Write-Host "Created folder: $tag"
    }
}

# Step 2: Copy matching jpg files to corresponding folders
foreach ($row in $csvData) {
    $imageName = $row.image_name
    $tag = $row.tags
    $sourceTest = "F:\GDrive\rainforest\planet\test-jpg\$imageName.jpg"
	$sourceTrain = "F:\GDrive\rainforest\planet\train-jpg\$imageName.jpg"
    $destinationPath = "F:\planetSort1\$tag\$imageName.jpg"

    # Check if the jpg file exists and copy it to the corresponding folder
    if (Test-Path -Path $sourceTest) {
        Copy-Item -Path $sourceTest -Destination $destinationPath
    } elseif (Test-Path -Path $sourceTrain){
		Copy-Item -Path $sourceTrain -Destination $destinationPath
	}else {
        Write-Host "JPG file not found for image: $imageName"
		
        $missingImages += $imageName
    }
}

# Write the list of missing image names to a text file
$missingImagesPath = "F:\MissingImages.txt"
$missingImages | Out-File -FilePath $missingImagesPath
Write-Host "List of missing images written to: $missingImagesPath"