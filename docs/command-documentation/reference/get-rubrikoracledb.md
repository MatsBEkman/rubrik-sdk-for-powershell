---
external help file: Rubrik-help.xml
Module Name: Rubrik
online version: https://rubrik.gitbook.io/rubrik-sdk-for-powershell/command-documentation/reference/get-rubrikoracledb
schema: 2.0.0
---

# Get-RubrikOracleDB

## SYNOPSIS
Retrieves details on one or more Oracle DBs known to a Rubrik cluster

## SYNTAX

### Query (Default)
```
Get-RubrikOracleDB [[-Name] <String>] [-Relic] [-LiveMount] [-DataGuardGroup] [-DetailedObject] [-SLA <String>]
 [-SLAAssignment <String>] [-PrimaryClusterID <String>] [-SLAID <String>] [-Server <String>] [-api <String>]
 [<CommonParameters>]
```

### ID
```
Get-RubrikOracleDB [-Relic] [-LiveMount] [-DataGuardGroup] [-DetailedObject] [-SLA <String>]
 [-SLAAssignment <String>] [-PrimaryClusterID <String>] [-id] <String> [-SLAID <String>] [-Server <String>]
 [-api <String>] [<CommonParameters>]
```

## DESCRIPTION
The Get-RubrikOracleDB cmdlet is used to pull a detailed data set from a Rubrik cluster on any number of Oracle DBs

## EXAMPLES

### EXAMPLE 1
```
Get-RubrikOracleDB -Name 'OracleDB1'
```

This will return details on all Oracle DBs named "OracleDB1".

### EXAMPLE 2
```
Get-RubrikOracleDB -Name 'OracleDB1' -SLA Gold
```

This will return details on all Oracle DBs named "OracleDB1" that are protected by the Gold SLA Domain.

### EXAMPLE 3
```
Get-RubrikOracleDB -Relic
```

This will return all removed Oracle DBs that were formerly protected by Rubrik.

### EXAMPLE 4
```
Get-RubrikOracleDB -DataGuardGroup
```

This will return all Oracle DBs belonging to a Data Guard Group.

### EXAMPLE 5
```
Get-RubrikOracleDB -Name OracleDB1 -DetailedObject
```

This will return the Oracle DB object with all properties, including additional details such as snapshots taken of the Oracle DB.
Using this switch parameter negatively affects performance as more API queries will be performed.

## PARAMETERS

### -Name
Name of the Oracle DB

```yaml
Type: String
Parameter Sets: Query
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Relic
Filter results to include only relic (removed) Oracle DBs

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: is_relic

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -LiveMount
{{ Fill LiveMount Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: is_live_mount

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -DataGuardGroup
Filter results to incldue only data guard group dbs

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: is_data_guard_group

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -DetailedObject
DetailedObject will retrieved the detailed VM object, the default behavior of the API is to only retrieve a subset of the full VM object unless we query directly by ID.
Using this parameter does affect performance as more data will be retrieved and more API-queries will be performed.

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

### -SLA
SLA Domain policy assigned to the Oracle DB

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SLAAssignment
Filter by SLA Domain assignment type

```yaml
Type: String
Parameter Sets: (All)
Aliases: sla_assignment

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PrimaryClusterID
Filter the summary information based on the primarycluster_id of the primary Rubrik cluster.
Use 'local' as the primary_cluster_id of the Rubrik cluster that is hosting the current REST API session.

```yaml
Type: String
Parameter Sets: (All)
Aliases: primary_cluster_id

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -id
Oracle DB id

```yaml
Type: String
Parameter Sets: ID
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SLAID
SLA id value

```yaml
Type: String
Parameter Sets: (All)
Aliases: effective_sla_domain_id

Required: False
Position: Named
Default value: None
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
Written by Jaap Brasser for community usage
Twitter: @jaap_brasser
GitHub: jaapbrasser

## RELATED LINKS

[https://rubrik.gitbook.io/rubrik-sdk-for-powershell/command-documentation/reference/get-rubrikoracledb](https://rubrik.gitbook.io/rubrik-sdk-for-powershell/command-documentation/reference/get-rubrikoracledb)

