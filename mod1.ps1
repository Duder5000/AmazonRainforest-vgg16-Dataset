# Path to the original CSV file
$csvPath = "C:\Users\Duder5000\Desktop\train_classes_mod.csv"

# Path to the new CSV file
$newCsvPath = "C:\Users\Duder5000\Desktop\train_classes_new.csv"

# Read the original CSV file
$csvData = Import-Csv -Path $csvPath -Header "Column1", "Column2"

# Initialize an empty array to store modified data
$modifiedData = @()

# Loop through each row in the CSV
foreach ($row in $csvData) {
    # Split the values in Column1 by the first space
    $splitColumn1 = $row.Column1 -split ' ', 2
    # Get the text before the first space in Column1
    $textBeforeSpace_Column1 = $splitColumn1[0]

    # Split the values in Column2 by the first space
    $splitColumn2 = $row.Column2 -split ' ', 2
    # Get the text before the first space in Column2
    $textBeforeSpace_Column2 = $splitColumn2[0]

    # Create a new object with modified values
    $modifiedRow = [PSCustomObject]@{
        Column1 = $textBeforeSpace_Column1
        Column2 = $textBeforeSpace_Column2
    }

    # Add the modified row to the array
    $modifiedData += $modifiedRow
}

# Export the modified data to a new CSV file
$modifiedData | Export-Csv -Path $newCsvPath -NoTypeInformation