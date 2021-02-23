MD C:\LAB6
cd C:\LAB6 
ver > os_version.txt
wmic os get TotalVisibleMemorySize > memory.txt
wmic os get FreePhysicalMemory >> memory.txt
wmic diskdrive get model,serialNumber,size,mediaType > disks.txt