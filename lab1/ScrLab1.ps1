param ($name, $type, $IP, $MASK, $GATEWAY, $DNS)

if ($type -eq 1)
{
    $IPType = "IPv4"
    $adapter = Get-NetAdapter | Select-Object $name
    $interface = $adapter 
    If ($interface.Dhcp -eq "Disabled") {
        If (($interface | Get-NetIPConfiguration).Ipv4DefaultGateway) {
            $interface | Remove-NetRoute -Confirm:$false
        }
    $interface | Set-NetIPInterface -DHCP Enabled
    $interface | Set-DnsClientServerAddress -ResetServerAddresses
    }
}
elseif ($type -eq 2)
{
    Set-NetIPInterface -InterfaceAlias $name -Dhcp Disabled
    $ip_params = @{
        InterfaceAlias=$name
        IP=$IP
        PrefixLength=$MASK
        DefaultGateway=$GATEWAY
        
        AddressFamily = "IPv4"
    }
    New-NetIPAddress @ip_params

    $dnsParams = @{
InterfaceAlias = $name
ServerAddresses = $DNS
}
Set-DnsClientServerAddress @dnsParams

}
else 
{
     Get-NetAdapter $name | Format-List -Property ifDesc, PhysicalMediaType, Speed, FullDuplex 
} 