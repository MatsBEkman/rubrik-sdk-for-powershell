---
external help file: Rubrik-help.xml
Module Name: Rubrik
online version: https://rubrik.gitbook.io/rubrik-sdk-for-powershell/command-documentation/reference/get-rubriksnapshot
schema: 2.0.0
---

# Get-RubrikSnapshot

## SYNOPSIS
Retrieves all of the snapshots (backups) for any given object

## SYNTAX

### Latest
```
Get-RubrikSnapshot -id <String> [-CloudState <Int32>] [-OnDemandSnapshot] [-Latest] [-Server <String>]
 [-api <String>] [<CommonParameters>]
```

### Date
```
Get-RubrikSnapshot -id <String> [-CloudState <Int32>] [-OnDemandSnapshot] -Date <DateTime> [-Range <Int32>]
 [-ExactMatch] [-Server <String>] [-api <String>] [<CommonParameters>]
```

### Query
```
Get-RubrikSnapshot -id <String> [-CloudState <Int32>] [-OnDemandSnapshot] [-Server <String>] [-api <String>]
 [<CommonParameters>]
```

### SnapshotID
```
Get-RubrikSnapshot [-CloudState <Int32>] [-OnDemandSnapshot] -SnapshotId <String> [-SnapshotType <String>]
 [-Server <String>] [-api <String>] [<CommonParameters>]
```

## DESCRIPTION
The Get-RubrikSnapshot cmdlet is used to query the Rubrik cluster for all known snapshots (backups) for any protected object
The correct API call will be made based on the object id submitted
Multiple objects can be piped into this function so long as they contain the id required for lookup

## EXAMPLES

### EXAMPLE 1
```
Get-RubrikSnapshot -id 'VirtualMachine:::aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee-vm-12345'
```

This will return all snapshot (backup) data for the virtual machine id of "VirtualMachine:::aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee-vm-12345"

### EXAMPLE 2
```
Get-RubrikSnapshot -id 'Fileset:::01234567-8910-1abc-d435-0abc1234d567'
```

This will return all snapshot (backup) data for the fileset with id of "Fileset:::01234567-8910-1abc-d435-0abc1234d567"

### EXAMPLE 3
```
Get-RubrikVM 'Server1' | Get-RubrikSnapshot -Date '03/21/2017'
```

This will return the closest matching snapshot, within 1 day, to March 21st, 2017 for any virtual machine named "Server1"

### EXAMPLE 4
```
Get-RubrikVM 'Server1' | Get-RubrikSnapshot -Date '03/21/2017' -Range 3
```

This will return the closest matching snapshot, within 3 days, to March 21st, 2017 for any virtual machine named "Server1"

### EXAMPLE 5
```
Get-RubrikVM 'Server1' | Get-RubrikSnapshot -Date '03/21/2017' -Range 3 -ExactMatch
```

This will return the closest matching snapshot, within 3 days, to March 21st, 2017 for any virtual machine named "Server1".
-ExactMatch specifies that no results are returned if a match is not found, otherwise all snapshots are returned.

### EXAMPLE 6
```
Get-RubrikVM 'Server1' | Get-RubrikSnapshot -Date (Get-Date)
```

This will return the closest matching snapshot to the current date and time for any virtual machine named "Server1"

### EXAMPLE 7
```
Get-RubrikVM 'Server1' | Get-RubrikSnapshot -Latest
```

This will return the latest snapshot for the virtual machine named "Server1"

### EXAMPLE 8
```
Get-RubrikSnapshot -SnapshotId 64914f54-fe71-40b2-84ae-933f1a55e1b9 -Verbose
```

Will query for specific SnapshotId querying common snapshot endpoints until a result is returned

### EXAMPLE 9
```
Get-RubrikSnapshot -SnapshotId 64914f54-fe71-40b2-84ae-933f1a55e1b9 -SnapshotType vmware/vm
```

Will query for specific SnapshotId for the vmware/vm/snapshot/{id} endpoint

## PARAMETERS

### -id
Rubrik id of the protected object

```yaml
Type: String
Parameter Sets: Latest, Date, Query
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -CloudState
Filter results based on where in the cloud the snapshot lives

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -OnDemandSnapshot
Filter results to show only snapshots that were created on demand

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

### -Date
Date of the snapshot

```yaml
Type: DateTime
Parameter Sets: Date
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Range
Range of how many days away from $Date to search for the closest matching snapshot.
Defaults to one day.

```yaml
Type: Int32
Parameter Sets: Date
Aliases:

Required: False
Position: Named
Default value: 1
Accept pipeline input: False
Accept wildcard characters: False
```

### -ExactMatch
Return no results if a matching date isn't found.
Otherwise, all snapshots are returned if no match is made.

```yaml
Type: SwitchParameter
Parameter Sets: Date
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SnapshotId
Query by the snapshot id directly, in case a snapshot id is known and the snapshot's information needs to be retrieved

```yaml
Type: String
Parameter Sets: SnapshotID
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SnapshotType
Specifies the snapshot type to query for the supplied

```yaml
Type: String
Parameter Sets: SnapshotID
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Latest
Return the latest snapshot

```yaml
Type: SwitchParameter
Parameter Sets: Latest
Aliases:

Required: True
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Written by Chris Wahl for community usage
Twitter: @ChrisWahl
GitHub: chriswahl

## RELATED LINKS

[https://rubrik.gitbook.io/rubrik-sdk-for-powershell/command-documentation/reference/get-rubriksnapshot](https://rubrik.gitbook.io/rubrik-sdk-for-powershell/command-documentation/reference/get-rubriksnapshot)

