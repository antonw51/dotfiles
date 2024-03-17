oh-my-posh --init --shell pwsh --config ~/AppData/Local/Programs/oh-my-posh/themes/custom.omp.json | Invoke-Expression

Function CD_CONFIG {cd "~/AppData/Local/nvim/"}
Set-Alias -Name nvim-config -Value CD_CONFIG


Function openpsconfig { nvim $PROFILE }
Set-Alias -Name psconfig -Value openpsconfig
Function cdback { cd .. }
Set-Alias -Name .. -Value cdback 
Function cdprojects { cd ~/Projects/ }
Set-Alias -Name pf -Value cdprojects

Function quit { Exit }
Set-Alias -Name q -Value quit

Function touch { echo $NULL >> $args }

Function openadmin { Start-Process -Verb runAs -FilePath "pwsh" -ArgumentList arguments && q }
Set-Alias -Name elevate -Value openadmin

Function nvid { neovide $ARGS }

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
