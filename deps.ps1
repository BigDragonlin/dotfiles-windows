# Check to see if we are currently running "as Administrator"
if (!(Verify-Elevated)) {
   $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";
   $newProcess.Arguments = $myInvocation.MyCommand.Definition;
   $newProcess.Verb = "runas";
   [System.Diagnostics.Process]::Start($newProcess);

   exit
}

# system and cli
# install git
winget install Git.Git                                   --silent --accept-package-agreements --accept-source-agreements --override "/VerySilent /NoRestart /o:PathOption=CmdTools /Components=""icons,assoc,assoc_sh,gitlfs"""

# 安装nodejs
winget install OpenJS.NodeJS                             --silent --accept-package-agreements --accept-source-agreements
winget install Python.Python.3.12                        --silent --accept-package-agreements --accept-source-agreements

# browsers
# 安装chrome
winget install Google.Chrome                             --silent --accept-package-agreements --accept-source-agreements

# dev tools and frameworks
# 安装poweshell
winget install Microsoft.PowerShell                      --silent --accept-package-agreements --accept-source-agreements
# 安装vim
winget install Vim.Vim                                   --silent --accept-package-agreements --accept-source-agreements

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

