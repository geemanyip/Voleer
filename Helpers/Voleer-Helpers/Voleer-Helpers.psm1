################################################################################
# Constants
################################################################################

# GitHub location
$baseUri = "https://api.github.com"
$owner = "geemanyip"
$repository = "Voleer"
$rootPath = "Helpers/Voleer-Helpers"

# Install location
$installDirRoot = "$($Home)\Documents\WindowsPowerShell\Modules\Geeman"
$installDirRepository = "$($installDirRoot)\Voleer"
$installDirModule = "$($installDirRepository)\Voleer-Helpers"

$publicDir = "$($installDirModule)\public"
$privateDir = "$($installDirModule)\private"

################################################################################
# Helper functions for installation
################################################################################

function DownloadGitHubFiles {
    Param(
        [string]$Owner,
        [string]$Repository,
        [string]$Path,
        [string]$DownloadDir
        )

    $uri = "$($baseUri)/repos/$($Owner)/$($Repository)/contents/$($Path)"
    Write-Verbose "Downloading file $($uri)" -Verbose
    $wr = Invoke-WebRequest -Uri $($uri)
    $json = $wr.Content | ConvertFrom-Json
    $files = $json | Where-Object {$_.type -eq "file"} | Select-Object -exp download_url
    $directories = $json | Where-Object {$_.type -eq "dir"}

    # recurse each directory
    $directories | ForEach-Object { 
        DownloadGitHubFiles -Owner $Owner -Repository $Repository -Path $_.path -DownloadDir "$($DownloadDir)\$($_.name)"
    }

    # Create destination directory
    if(-not (Test-Path $DownloadDir)) {
        try {
            New-Item -Path $DownloadDir -ItemType Directory
        }
        catch {
            throw "Unable to create destination directory '$($DownloadDir)': $_"
        }
    }

    # Download files to directory
    foreach ($file in $files) {
        $destination = Join-Path $DownloadDir (Split-Path $file -Leaf)
        try {
            Write-Verbose "Downloading '$($file)' to '$destination'" -Verbose
            Invoke-WebRequest -Uri $file -OutFile $destination -ErrorAction Stop -Verbose
        } catch {
            throw "Unable to download '$($file.path)': $_"
        }
    }
}

################################################################################
# Prepare local environment
################################################################################
Write-Verbose "Preparing local environment" -Verbose

# Create root director
if(-not (Test-Path $installDirRoot)) {
    Write-Verbose "Creating root install directory $($installDirRoot)" -Verbose
    New-Item -Path $installDirRoot -ItemType Directory
}
else {
    Write-Verbose "Root install directory $($installDirRoot) already exists" -Verbose
}

# Create repo directory so that we can support multile repos
if(-not (Test-Path $installDirRepository)) {
    Write-Verbose "Creating repository install directory $($installDirRepository)" -Verbose
    New-Item -Path $installDirRepository -ItemType Directory
}
else {
    Write-Verbose "Repository install directory $($installDirRepository) already exists" -Verbose
}

# Remove previous install
if(Test-Path $installDirModule) {
    Write-Verbose "Removing previously installed module directory $($installDirModule)" -Verbose
    Remove-Item -Path $installDirModule -Force -Recurse
}

# Create module directory so that we can support multiple modules from the same repo
if(-not (Test-Path $installDirModule)) {
    Write-Verbose "Creating module install directory $($installDirModule)" -Verbose
    New-Item -Path $installDirModule -ItemType Directory
}
else {
    Write-Verbose "Module install directory $($installDirModule) already exists" -Verbose
}

################################################################################
# Download all files from GitHub repository
################################################################################
Write-Verbose "Downloading files from GitHub repository" -Verbose

DownloadGitHubFiles -Owner $owner -Repository $repository -Path $rootPath -DownloadDir $installDirModule

################################################################################
# Install module
################################################################################
Write-Verbose "Exporting public modules" -Verbose

# Get public and private function definition files.
$public  = @(Get-ChildItem -Path $publicDir\*.ps1 -ErrorAction SilentlyContinue)
$private = @(Get-ChildItem -Path $privateDir\*.ps1 -ErrorAction SilentlyContinue)

# Dot source the files
foreach($import in @($public + $private))
{
    try {
        . $import.fullname
    }
    catch {
        throw "Failed to import function $($import.fullname): $_"
    }
}

# Export public functions
Export-ModuleMember -Function $Public.Basename