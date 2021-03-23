On the Windows VM, open a PowerShell prompt as Administrator and run:

```powershell
PS > Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force
PS > . { Invoke-WebRequest -useb https://boxstarter.org/bootstrapper.ps1 } | iex; Get-Boxstarter -Force
```

Once the installation has completed, a Boxstarter Shell icon will appear on your desktop.  Launch the Boxstarter Shell and enter the following command:

```powershell
PS > Install-BoxstarterPackage -PackageName https://github.com/mostwantedduck/setup-machines/raw/main/setup-windows.choco
```
 
