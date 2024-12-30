### Jay Harris's Windows dotfiles

Jay Harris 的 dotfiles 是一组为 Windows 提供的 PowerShell 文件，包括通过 `Win-Get` 和 `npm` 安装常见应用程序以及为开发者配置的 Windows 默认设置。

---

### Installation

### Using Git and the bootstrap script

You can clone the repository wherever you want. (I like to keep it in `~\Projects\dotfiles-windows`.) The bootstrapper script will copy the files to your PowerShell Profile folder.

从 Git 仓库克隆项目后，引导脚本会将文件复制到 PowerShell 配置文件夹中。（我习惯将其保存在 `~\Projects\dotfiles-windows`。）

```posh
git clone https://github.com/jayharris/dotfiles-windows.git; cd dotfiles-windows; . .\bootstrap.ps1
```

To update your settings, `cd` into your local `dotfiles-windows` repository within PowerShell and then:

若要更新配置，请进入本地的 `dotfiles-windows` 目录并运行以下命令：

```posh
. .\bootstrap.ps1
```

Note: You must have your execution policy set to unrestricted (or at least in bypass) for this to work: `Set-ExecutionPolicy Unrestricted`.

注意：您必须将 PowerShell 的执行策略设置为不受限制或绕过模式：`Set-ExecutionPolicy Unrestricted`。

---

### Git-free install

To install these dotfiles from PowerShell without Git:

如果没有安装 Git，也可以使用以下命令从 PowerShell 安装：

```bash
iex ((new-object net.webclient).DownloadString('https://raw.github.com/jayharris/dotfiles-windows/master/setup/install.ps1'))
```

To update later on, just run that command again.

稍后要更新，只需再次运行此命令。

---

### Use & Configuration

### PowerShell Profile

The following commands are executed every time you launch a new PowerShell window.

以下命令会在每次启动 PowerShell 窗口时执行：

- `.\components.ps1`: Load various PowerShell components and modules.  
  加载各种 PowerShell 组件和模块。

- `.\functions.ps1`: Configure custom PowerShell functions.  
  配置自定义 PowerShell 函数。

- `.\aliases.ps1`: Configure alias-based commands.  
  配置别名命令。

- `.\exports.ps1`: Configure environment variables.  
  配置环境变量。

- `.\extra.ps1`: Secrets and secret commands that are not tracked by the Git repository.  
  包含秘密信息和不被 Git 仓库跟踪的命令。

---

### Secrets

If you have sensitive information (e.g., API tokens) or custom settings, you can place them in `.\extra.ps1`.

如果有敏感信息（例如 API 密钥）或自定义设置，可以将它们放入 `.\extra.ps1` 文件。

---

### Sensible Windows Defaults

When setting up a new Windows PC, you may want to apply default configurations, such as showing hidden files or uninstalling unwanted applications.

在配置新的 Windows PC 时，可以应用默认设置，例如显示隐藏文件或卸载不需要的应用程序。

```posh
.\windows.ps1
```

---

### Dependencies

You can use `deps.ps1` to install common tools, utilities, and packages required for development.

可以使用 `deps.ps1` 安装开发所需的常用工具、实用程序和软件包。

---

### Customization

These scripts are designed based on the author's preferences. You can fork the repository to customize it according to your own needs.

这些脚本基于作者的偏好设计。您可以分叉仓库并根据自己的需求进行定制。

---

### Feedback

Suggestions or improvements are welcome through the Issues page of the repository.

欢迎通过仓库的 Issues 页面提出建议或改进。

---

### Author

| [![twitter/jayharris](http://gravatar.com/avatar/1318668b99b2d5a3900f3f7758763a69?s=70)](http://twitter.com/jayharris "Follow @jayharris on Twitter") |  
|---|  
| [Jay Harris](http://twitter.com/jayharris/) |  

---

### Thanks to…

Special thanks to @[Mathias Bynens](http://mathiasbynens.be/) for his macOS dotfiles, which inspired this repository.

特别感谢 @[Mathias Bynens](http://mathiasbynens.be/) 的 macOS dotfiles 项目，为本仓库提供了灵感。