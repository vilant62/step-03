#Initialize data disk on letter F:
Get-Disk|Where-Object{$_.PartitionStyle -eq "Raw"} |`
Initialize-Disk -PartitionStyle "GPT" -PassThru |`
New-Partition -UseMaximumSize -DriveLetter "F"  |`
Format-Volume -FileSystem "NTFS" -NewFileSystemLabel "Data_disk" -Confirm:$false -Force
#Create folders for new site
New-Item -ItemType "directory" -Path F:\wwwroot
#Install IIS
add-windowsfeature "web-server" -IncludeManagementTools

