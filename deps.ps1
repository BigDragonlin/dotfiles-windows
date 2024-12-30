# Check to see if we are currently running "as Administrator"
if (!(Verify-Elevated)) {
   $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";
   $newProcess.Arguments = $myInvocation.MyCommand.Definition;
   $newProcess.Verb = "runas";
   [System.Diagnostics.Process]::Start($newProcess);

   exit
}

# 定义函数以检查软件是否已安装
function Check-SoftwareInstalled {
    param (
        [string]$SoftwareID
    )
    $installed = winget list --id $SoftwareID 2>&1 | Out-String
    return $installed -notmatch "No installed package found matching input criteria"
}

# 定义需要安装的软件列表
$softwareList = @(
    @{ Name = "Visual Studio Community 2022"; ID = "Microsoft.VisualStudio.2022.Community" },
    # @{ Name = "Cursor"; ID = "Anysphere.Cursor" },
    @{ Name = "Anki"; ID = "Anki.Anki" },
    @{ Name = "AutoHotkey"; ID = "AutoHotkey.AutoHotkey" },
    @{ Name = "Google Chrome"; ID = "Google.Chrome" },
    # @{ Name = "Docker Desktop"; ID = "Docker.DockerDesktop" },
    # @{ Name = "DBeaver"; ID = "dbeaver.dbeaver" },
    @{ Name = "Ditto"; ID = "Ditto.Ditto" },
    @{ Name = "PowerToys"; ID = "Microsoft.PowerToys" },
    @{ Name = "Node.js LTS"; ID = "OpenJS.NodeJS.LTS" },
    @{ Name = "Notepad++"; ID = "Notepad++.Notepad++" },
    @{ Name = "TortoiseSVN"; ID = "TortoiseSVN.TortoiseSVN" },
    # @{ Name = "Telegram Desktop"; ID = "Telegram.TelegramDesktop" },
    @{ Name = "Python 3.12"; ID = "Python.Python.3.12" },
    @{ Name = "Logitech G HUB"; ID = "Logitech.GHUB" },
    @{ Name = "Unity Hub"; ID = "Unity.UnityHub" },
    @{ Name = "网易有道翻译"; ID = "Youdao.YoudaoTranslate" },
    @{ Name = "百度网盘"; ID = "Baidu.BaiduNetdisk" },
    @{ Name = "JetBrains Toolbox"; ID = "JetBrains.Toolbox" }
)

# 遍历安装列表并检查软件是否已安装
foreach ($software in $softwareList) {
    if (-not (Check-SoftwareInstalled $software.ID)) {
        Write-Host "正在安装: $($software.Name)..." -ForegroundColor Yellow
        winget install --id $software.ID --silent --accept-package-agreements --accept-source-agreements
    } else {
        Write-Host "$($software.Name) 已安装，跳过。" -ForegroundColor Green
    }
}

Write-Host "所有软件安装完成！" -ForegroundColor Cyan


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

