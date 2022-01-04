#Requires -Version 3
function Get-RubrikSnapshot
{
  <#
    .SYNOPSIS
    Retrieves all of the snapshots (backups) for any given object
    
    .DESCRIPTION
    The Get-RubrikSnapshot cmdlet is used to query the Rubrik cluster for all known snapshots (backups) for any protected object
    The correct API call will be made based on the object id submitted
    Multiple objects can be piped into this function so long as they contain the id required for lookup
    
    .NOTES
    Written by Chris Wahl for community usage
    Twitter: @ChrisWahl
    GitHub: chriswahl
    
    .LINK
    https://rubrik.gitbook.io/rubrik-sdk-for-powershell/command-documentation/reference/get-rubriksnapshot
    
    .EXAMPLE
    Get-RubrikSnapshot -id 'VirtualMachine:::aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee-vm-12345'

    This will return all snapshot (backup) data for the virtual machine id of "VirtualMachine:::aaaaaaaa-bbbb-cccc-dddd-eeeeeeeeeeee-vm-12345"

    .EXAMPLE
    Get-RubrikSnapshot -id 'Fileset:::01234567-8910-1abc-d435-0abc1234d567'

    This will return all snapshot (backup) data for the fileset with id of "Fileset:::01234567-8910-1abc-d435-0abc1234d567"

    .EXAMPLE
    Get-RubrikVM 'Server1' | Get-RubrikSnapshot -Date '03/21/2017'

    This will return the closest matching snapshot, within 1 day, to March 21st, 2017 for any virtual machine named "Server1"

    .EXAMPLE
    Get-RubrikVM 'Server1' | Get-RubrikSnapshot -Date '03/21/2017' -Range 3

    This will return the closest matching snapshot, within 3 days, to March 21st, 2017 for any virtual machine named "Server1"

    .EXAMPLE
    Get-RubrikVM 'Server1' | Get-RubrikSnapshot -Date '03/21/2017' -Range 3 -ExactMatch

    This will return the closest matching snapshot, within 3 days, to March 21st, 2017 for any virtual machine named "Server1". -ExactMatch specifies that no results are returned if a match is not found, otherwise all snapshots are returned.

    .EXAMPLE
    Get-RubrikVM 'Server1' | Get-RubrikSnapshot -Date (Get-Date)
    
    This will return the closest matching snapshot to the current date and time for any virtual machine named "Server1"

    .EXAMPLE
    Get-RubrikVM 'Server1' | Get-RubrikSnapshot -Latest

    This will return the latest snapshot for the virtual machine named "Server1"

    .EXAMPLE
    Get-RubrikSnapshot -SnapshotId 64914f54-fe71-40b2-84ae-933f1a55e1b9 -Verbose

    Will query for specific SnapshotId querying common snapshot endpoints until a result is returned

    .EXAMPLE
    Get-RubrikSnapshot -SnapshotId 64914f54-fe71-40b2-84ae-933f1a55e1b9 -SnapshotType vmware/vm

    Will query for specific SnapshotId for the vmware/vm/snapshot/{id} endpoint
  #>

  [CmdletBinding()]
  Param(
    # Rubrik id of the protected object
    [Parameter(Mandatory = $true,ValueFromPipelineByPropertyName = $true,ParameterSetName='Query')]
    [Parameter(Mandatory = $true,ValueFromPipelineByPropertyName = $true,ParameterSetName='Date')]
    [Parameter(Mandatory = $true,ValueFromPipelineByPropertyName = $true,ParameterSetName='Latest')]
    [ValidateNotNullOrEmpty()]
    [String]$id,
    # Filter results based on where in the cloud the snapshot lives
    [Int]$CloudState,
    # Filter results to show only snapshots that were created on demand
    [Switch]$OnDemandSnapshot,
    # Date of the snapshot
    [Parameter(Mandatory = $true,ParameterSetName='Date')]
    [ValidateNotNullOrEmpty()]
    [Datetime]$Date,
    # Range of how many days away from $Date to search for the closest matching snapshot. Defaults to one day.
    [Parameter(ParameterSetName='Date')]
    [Int]$Range = 1,
    # Return no results if a matching date isn't found. Otherwise, all snapshots are returned if no match is made.
    [Parameter(ParameterSetName='Date')]
    [Switch]$ExactMatch,
    # Query by the snapshot id directly, in case a snapshot id is known and the snapshot's information needs to be retrieved
    [Parameter(
      ParameterSetName='SnapshotID',
      Mandatory=$true
    )]
    [string]$SnapshotId,
    # Specifies the snapshot type to query for the supplied 
    [Parameter(
      ParameterSetName='SnapshotID'
    )]
    [ValidateSet(
      'fileset', 'mssql/db', 'vmware/vm',
      'hyperv/vm', 'managed_volume', 'nutanix/vm',
      'volume_group', 'oracle/db', 'vcd/vapp'
    )]
    [string]$SnapshotType,
    # Return the latest snapshot
    [Parameter(Mandatory = $true,ParameterSetName='Latest')]
    [Switch]$Latest,
    # Rubrik server IP or FQDN
    [String]$Server = $global:RubrikConnection.server,
    # API version
    [ValidateNotNullorEmpty()]
    [String]$api = $global:RubrikConnection.api
  )


  Begin {

    # The Begin section is used to perform one-time loads of data necessary to carry out the function's purpose
    # If a command needs to be run with each iteration or pipeline input, place it in the Process section
    
    # Check to ensure that a session to the Rubrik cluster exists and load the needed header data for authentication
    Test-RubrikConnection
    
    # API data references the name of the function
    # For convenience, that name is saved here to $function
    $function = $MyInvocation.MyCommand.Name

    # Retrieve all of the URI, method, body, query, result, filter, and success details for the API endpoint
    Write-Verbose -Message "Gather API Data for $function"
    $resources = Get-RubrikAPIData -endpoint $function
    Write-Verbose -Message "Load API data for $($resources.Function)"
    Write-Verbose -Message "Description: $($resources.Description)"
  
  }

  Process {
    if ($SnapshotId -and $SnapshotType) {
      $uri = New-URIString -Server $server -Endpoint "/api/v1/$SnapshotType/snapshot" -id $SnapshotId

      $internaltypes = @(
        'hyperv/vm', 'managed_volume', 'nutanix/vm', 'volume_group', 'oracle/db', 'vcd/vapp'
      )
      if ($internaltypes -contains $Type) {
        $uri = $uri -replace 'v1', 'internal'
      }

      $result = Submit-Request -uri $uri -header $Header -method $($resources.Method) -body $body
      return $result
    } elseif ($SnapshotId) {
      $Internaltypes = 'hyperv/vm', 'managed_volume', 'nutanix/vm', 'volume_group', 'oracle/db', 'vcd/vapp'

      # Mainloop
      'fileset', 'mssql/db', 'vmware/vm',
      'hyperv/vm', 'managed_volume', 'nutanix/vm',
      'volume_group', 'oracle/db', 'vcd/vapp' | ForEach-Object {
        if (-not $result) {
          if ($_ -in $internaltypes) {
            $uri = New-URIString -Server $server -Endpoint "/api/internal/$_/snapshot" -id $SnapshotId
          } else {
            $uri = New-URIString -Server $server -Endpoint "/api/v1/$_/snapshot" -id $SnapshotId
          }
          
          # Submit request & return result if available
          $result = Submit-Request -uri $uri -header $Header -method $($resources.Method) -body $body -DoNotThrow -ErrorAction SilentlyContinue
          if ($Result) {
            return $result
          }
        } else {
          # Do nothing, once a result is found finish loop without further querying
        }
      }
    } else {

      $uri = Test-QueryParam -querykeys ($resources.Query.Keys) -parameters ((Get-Command $function).Parameters.Values) -uri $uri
      
      # Exclusion for FileSet because limited API endpoint functionality, using expanded properties to gather snapshot details
      if ($uri -match 'v1/fileset') {
        $result = (Get-RubrikFileset -Id $Id).snapshots
      } else {
        $body = New-BodyString -bodykeys ($resources.Body.Keys) -parameters ((Get-Command $function).Parameters.Values)
        $result = Submit-Request -uri $uri -header $Header -method $($resources.Method) -body $body
        $result = Test-ReturnFormat -api $api -result $result -location $resources.Result
      }    
      
      $result = Test-FilterObject -filter ($resources.Filter) -result $result
      
      #region One-off
      if ($Date) {
        $datesearch = Test-DateDifference -Date $($result.date) -Compare $Date -Range $Range
        # If $datesearch is $null, a matching date was not found. If $ExactMatch is specified in this case, return $null
        if($null -eq $datesearch -and $ExactMatch) {
          $result = $null
        } else {
          $result = Test-ReturnFilter -Object $datesearch -Location 'date' -result $result
        }
      } elseif ($Latest) {
        $datesearch = Test-DateDifference -Date $($result.date) -Compare (Get-Date).ToUniversalTime() -Range 999999999
        # If $datesearch is $null, a matching date was not found, so return $null
        if($null -eq $datesearch) {
          $result = $null
        } else {
          $result = Test-ReturnFilter -Object $datesearch -Location 'date' -result $result
        }
      } 
      #endregion

      return $result

    }

  } # End of process
} # End of function