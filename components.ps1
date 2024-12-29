# These components will be loaded for all PowerShell instances
# PowerShell的组件和模块

# 获取当前 PowerShell 配置文件 ($profile) 的父目录，并切换到该目录下的 "components" 子目录
Push-Location (Join-Path (Split-Path -parent $profile) "components")

# From within the ./components directory...
. .\coreaudio.ps1
. .\git.ps1

# 返回之前的目录
Pop-Location
