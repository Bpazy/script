If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{   
    $arguments = "& '" + $myinvocation.mycommand.definition + "'"
    Start-Process powershell -Verb runAs -ArgumentList $arguments
    Break
}

$NAME = "以太网 3"

# set ip exact
netsh interface ipv4 set address $NAME static 192.168.1.87 255.255.255.0 192.168.1.1
# set dns
netsh interface ipv4 set dns $NAME static 192.168.1.1

# set ip dhcp
# netsh.exe interface ipv4 set address $NAME dhcp
