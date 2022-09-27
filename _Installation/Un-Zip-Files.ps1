$ZipFilesPath =  ".\_Installation\Zip-Files"

$UnzipBase    =  ".\Temp"

$Shell = New-Object -com Shell.Application
Write-Host "Running Un-Zip-Files.ps1 . . ."

$ZipFiles = Get-Childitem $ZipFilesPath -Recurse -Include *.ZIP

$progress = 1

foreach ($ZipFile in $ZipFiles) {

    Write-Host "Un-Zipping "$ZipFile" . . ."

    Write-Progress -Activity "Unzipping to $($UnzipPath)" `
      -PercentComplete (($progress / ($ZipFiles.Count + 1)) * 100) `
      -CurrentOperation $ZipFile.FullName `
      -Status "File $($Progress) of $($ZipFiles.Count)"

    $ZipFolder = $Shell.NameSpace($ZipFile.fullname)

    $UnzipPath = Join-Path $UnzipBase $ZipFile.BaseName

    New-Item $UnzipPath -ItemType Directory | Out-NULL

    Expand-Archive $ZipFile.fullname -DestinationPath $UnzipPath 

    $progress++
}