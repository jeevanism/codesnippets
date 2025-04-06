# Install wkhtmltopdf (optional, if not already installed)
# winget install wkhtmltopdf

$wkhtmlPath = "D:\bin\wkhtmltopdf.exe"
$sourceBaseDir = "D:\sourcehtmlfolder"
$destinationBaseDir = "D:\pdfdocs"

# Create the destination base directory if it doesn't exist
if (-not (Test-Path -Path $destinationBaseDir -PathType Container)) {
    Write-Host "Creating destination directory: $destinationBaseDir"
    New-Item -Path $destinationBaseDir -ItemType Directory -Force
}

Get-ChildItem -Path $sourceBaseDir -Recurse -Filter "*.html" | ForEach-Object {
    # Construct the relative path of the HTML file from the source base directory
    $relativePath = $_.FullName.Substring($sourceBaseDir.Length).TrimStart('\', '/')

    # Create the corresponding subdirectory structure in the destination directory
    $destinationSubDir = Join-Path $destinationBaseDir ($relativePath | Split-Path -Parent)
    if (-not (Test-Path -Path $destinationSubDir -PathType Container)) {
        New-Item -Path $destinationSubDir -ItemType Directory -Force
    }

    # Construct the full path for the output PDF file
    $pdfFileName = $_.BaseName + ".pdf"
    $pdfPath = Join-Path $destinationSubDir $pdfFileName

    Write-Host "Converting: $($_.FullName) -> $pdfPath"
    & $wkhtmlPath --enable-local-file-access $_.FullName $pdfPath
}

Write-Host "HTML to PDF conversion completed. PDFs are located in: $destinationBaseDir"
