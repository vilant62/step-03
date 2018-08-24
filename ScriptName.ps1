param (
    # Url to site content
    [Parameter()]
    [String]
    $ContentUri="https://raw.githubusercontent.com/vilant62/step-03/master/index.html"
)
#Initialize data disk on letter F:
Get-Disk|Where-Object{$_.PartitionStyle -eq "Raw"} |`
Initialize-Disk -PartitionStyle "GPT" -PassThru |`
New-Partition -UseMaximumSize -DriveLetter "F"  |`
Format-Volume -FileSystem "NTFS" -NewFileSystemLabel "Data_disk" -Confirm:$false -Force
#Install IIS
add-windowsfeature "web-server" -IncludeManagementTools
#Create folders for new site
New-Item -ItemType "directory" -Path F:\wwwroot
#Add site content from repository
Invoke-WebRequest -Uri $ContentUri -UseBasicParsing -OutFile F:\wwwroot\index.html
#Configure new IIS site
Remove-WebSite -Name "Default Web Site"
New-WebSite -Name "MySite" -Port 80 -PhysicalPath "F:\wwwroot" -ApplicationPool DefaultAppPool
& iisreset 