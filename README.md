On the Windows VM, open a powershell prompt as **Administrator** and run:

```powershell
PS > Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Force
PS > . { Invoke-WebRequest -useb https://boxstarter.org/bootstrapper.ps1 } | iex; Get-Boxstarter -Force
```

Once the installation has completed, a Boxstarter Shell icon will appear on your desktop.  Launch the Boxstarter Shell and enter the following command:

```powershell
PS > Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/mostwantedduck/setup-machines/main/windows10.choco
```
 
On the Kali VM, open a terminal and run:

```bash
kali@kali:~$ curl -s https://raw.githubusercontent.com/mostwantedduck/setup-machines/main/kali.sh | bash 
```
