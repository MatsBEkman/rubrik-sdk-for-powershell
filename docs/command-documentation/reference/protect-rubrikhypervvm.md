---
external help file: Rubrik-help.xml
Module Name: Rubrik
online version: https://rubrik.gitbook.io/rubrik-sdk-for-powershell/command-documentation/reference/protect-rubrikhypervvm
schema: 2.0.0
---

# Protect-RubrikHyperVVM

## SYNOPSIS
Connects to Rubrik and assigns an SLA to a virtual machine

## SYNTAX

### None (Default)
```
Protect-RubrikHyperVVM -id <String> [-SLAID <String>] [-Server <String>] [-api <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### SLA_Explicit
```
Protect-RubrikHyperVVM -id <String> [-SLA <String>] [-SLAID <String>] [-Server <String>] [-api <String>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

### SLA_Inherit
```
Protect-RubrikHyperVVM -id <String> [-Inherit] [-SLAID <String>] [-Server <String>] [-api <String>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

### SLA_Unprotected
```
Protect-RubrikHyperVVM -id <String> [-DoNotProtect] [-SLAID <String>] [-ExistingSnapshotRetention <String>]
 [-Server <String>] [-api <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
The Protect-RubrikHyperVVM cmdlet will update a virtual machine's SLA Domain assignment within the Rubrik cluster.
The SLA Domain contains all policy-driven values needed to protect workloads.
Note that this function requires the virtual machine ID value, not the name of the virtual machine, since virtual machine names are not unique across clusters.
It is suggested that you first use Get-RubrikHyperVVM to narrow down the one or more virtual machine to protect, and then pipe the results to Protect-RubrikVM.
You will be asked to confirm each virtual machine you wish to protect, or you can use -Confirm:$False to skip confirmation checks.

## EXAMPLES

### EXAMPLE 1
```
Get-RubrikHyperVVM "VM1" | Protect-RubrikHyperVVM -SLA 'Gold'
```

This will assign the Gold SLA Domain to any virtual machine named "VM1"

### EXAMPLE 2
```
Get-RubrikHyperVVM "VM1" -SLA Silver | Protect-RubrikHyperVVM -SLA 'Gold' -Confirm:$False
```

This will assign the Gold SLA Domain to any virtual machine named "VM1" that is currently assigned to the Silver SLA Domain
without asking for confirmation

### EXAMPLE 3
```
Get-RubrikHyperVVM "VM1" | Protect-RubrikHyperVVM -DoNotProtect -ExistingSnapshotRetention KeepForever
```

This will unprotect the VM1 HyperV VM while keeping existing snapshots forever

## PARAMETERS

### -id
Virtual machine ID

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SLA
The SLA Domain in Rubrik

```yaml
Type: String
Parameter Sets: SLA_Explicit
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Inherit
Inherits the SLA Domain assignment from a parent object

```yaml
Type: SwitchParameter
Parameter Sets: SLA_Inherit
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -DoNotProtect
Removes the SLA Domain assignment

```yaml
Type: SwitchParameter
Parameter Sets: SLA_Unprotected
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SLAID
SLA id value

```yaml
Type: String
Parameter Sets: (All)
Aliases: configuredSlaDomainId

Required: False
Position: Named
Default value: (Test-RubrikSLA -SLA $SLA -DoNotProtect $DoNotProtect -Inherit $Inherit -Mandatory:$true)
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExistingSnapshotRetention
Determine the retention settings for the already existing snapshots

```yaml
Type: String
Parameter Sets: SLA_Unprotected
Aliases:

Required: False
Position: Named
Default value: RetainSnapshots
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
Position: Named
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
Position: Named
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
Written by Mike Fal for community usage
Twitter: @Mike_Fal
GitHub: MikeFal

## RELATED LINKS

[https://rubrik.gitbook.io/rubrik-sdk-for-powershell/command-documentation/reference/protect-rubrikhypervvm](https://rubrik.gitbook.io/rubrik-sdk-for-powershell/command-documentation/reference/protect-rubrikhypervvm)

