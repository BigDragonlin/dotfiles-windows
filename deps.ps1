# Check to see if we are currently running "as Administrator"
if (!(Verify-Elevated)) {
   $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";
   $newProcess.Arguments = $myInvocation.MyCommand.Definition;
   $newProcess.Verb = "runas";
   [System.Diagnostics.Process]::Start($newProcess);

   exit
}


# Function to check if a software is installed
function Check-SoftwareInstalled {
    param (
        [string]$SoftwareName
    )
    # Use winget list to check if the software is already installed
    $installed = winget list --name $SoftwareName 2>&1 | Out-String
    return $installed -notmatch "No installed package found matching input criteria"
}

# Install Git
if (-not (Check-SoftwareInstalled "Git")) {
    winget install Git.Git --silent --accept-package-agreements --accept-source-agreements --override "/VerySilent /NoRestart /o:PathOption=CmdTools /Components=""icons,assoc,assoc_sh,gitlfs"""
}

# Install Node.js
if (-not (Check-SoftwareInstalled "Node.js")) {
    winget install OpenJS.NodeJS --silent --accept-package-agreements --accept-source-agreements
}

# Install Python
if (-not (Check-SoftwareInstalled "Python")) {
    winget install Python.Python.3.12 --silent --accept-package-agreements --accept-source-agreements
}

# Install Google Chrome
if (-not (Check-SoftwareInstalled "Google Chrome")) {
    winget install Google.Chrome --silent --accept-package-agreements --accept-source-agreements
}

# Install PowerShell
if (-not (Check-SoftwareInstalled "PowerShell")) {
    winget install Microsoft.PowerShell --silent --accept-package-agreements --accept-source-agreements
}

# Install Vim
if (-not (Check-SoftwareInstalled "Vim")) {
    winget install Vim.Vim --silent --accept-package-agreements --accept-source-agreements
}

Refresh-Environment

gem pristine --all --env-shebang
Get-ChildItem 'C:\Program Files\Vim\' -Filter "vim*" -ErrorAction SilentlyContinue | Select-Object -First 1 | ForEach-Object {Append-EnvPath $_.FullName}

### Node Packages
Write-Host "Installing Node Packages..." -ForegroundColor "Yellow"
if (which npm) {
    npm update npm
    npm install -g yo
}

### Janus for vim
Write-Host "Installing Janus..." -ForegroundColor "Yellow"
if ((which curl) -and (which vim) -and (which rake) -and (which bash)) {
    curl.exe -L https://bit.ly/janus-bootstrap | bash

    cd ~/.vim/
    git submodule update --remote
}

