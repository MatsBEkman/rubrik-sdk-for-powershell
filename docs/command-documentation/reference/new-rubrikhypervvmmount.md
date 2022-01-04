---
external help file: Rubrik-help.xml
Module Name: Rubrik
online version: https://rubrik.gitbook.io/rubrik-sdk-for-powershell/command-documentation/reference/new-rubrikhypervvmmount
schema: 2.0.0
---

# New-RubrikHyperVVMMount

## SYNOPSIS
Create a new Live Mount from a protected Hyper V VM

## SYNTAX

```
New-RubrikHyperVVMMount [-id] <String> [[-HostID] <String>] [[-MountName] <String>] [-DisableNetwork]
 [-RemoveNetworkDevices] [-PowerOn] [[-Server] <String>] [[-api] <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
The New-RubrikHyperVVMMount cmdlet is used to create a Live Mount (clone) of a protected HyperV VM and run it in an existing HyperV environment.

## EXAMPLES

### EXAMPLE 1
```
New-RubrikHyperVVMMount -id '11111111-2222-3333-4444-555555555555'
```

This will create a new mount based on snapshot id "11111111-2222-3333-4444-555555555555"
The original virtual machine's name will be used along with a date and index number suffix
The virtual machine will be powered on upon completion of the mount operation

### EXAMPLE 2
```
New-RubrikHyperVVMMount -id '11111111-2222-3333-4444-555555555555' -MountName 'Mount1' -PowerOn:$false -RemoveNetworkDevices
```

This will create a new mount based on snapshot id "11111111-2222-3333-4444-555555555555" and name the mounted virtual machine "Mount1"
The virtual machine will NOT be powered on upon completion of the mount operation but without any virtual network adapters

### EXAMPLE 3
```
Get-RubrikHyperVVM 'Server1' | Get-RubrikSnapshot -Date '03/01/2017 01:00' | New-RubrikHyperVVMMount -MountName 'Mount1' -DisableNetwork -PowerOn
```

This will create a new mount based on the closet snapshot found on March 1st, 2017 @ 01:00 AM and name the mounted virtual machine "Mount1"
The virtual machine will be powered on upon completion of the mount operation

## PARAMETERS

### -id
Rubrik id of the snapshot

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -HostID
ID of host for the mount to use

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MountName
Name of the mounted VM

```yaml
Type: String
Parameter Sets: (All)
Aliases: vmName

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DisableNetwork
Whether the network should be disabled on mount.This should be set true to avoid ip conflict in case of static IPs.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -RemoveNetworkDevices
Whether the network devices should be removed on mount.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -PowerOn
Whether the VM should be powered on after mount.
Without this parameter the VM defaults to be powered on.
To ensure it isn't, specify -PoweredOn:$false

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Server
Rubrik server IP or FQDN

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: $global:RubrikConnection.server
Accept pipeline input: False
Accept wildcard characters: False
```

### -api
API version

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: $global:RubrikConnection.api
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Written by Mike Preston for community usage
Twitter: @mwpreston
GitHub: mwpreston

## RELATED LINKS

[https://rubrik.gitbook.io/rubrik-sdk-for-powershell/command-documentation/reference/new-rubrikhypervvmmount](https://rubrik.gitbook.io/rubrik-sdk-for-powershell/command-documentation/reference/new-rubrikhypervvmmount)

