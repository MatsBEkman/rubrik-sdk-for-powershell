﻿function Test-QueryParam($querykeys, $parameters, $uri) {
  <#
    .SYNOPSIS
    Builds a URI with query parameters for an endpoint

    .DESCRIPTION
    The Test-QueryParam function is used to build and test a custom query string for supported endpoints.
    In the event that multiple uris are detected, ID is used to determine the appropriate URI.

    .PARAMETER querykeys
    The endpoints query keys as defined in Get-RubrikAPIData
    
    .PARAMETER parameters
    The set of parameters passed within the cmdlets invocation

    .PARAMETER uri
    The endpoints URI
  #>

  # For functions that can address multiple different endpoints based on the $id value
  # If there are multiple URIs referenced in the API resources, we know this is true
  if (($resources.URI).count -ge 2) {  
    Write-Verbose -Message "Multiple URIs detected. Selecting URI based on $id"
    Switch -Wildcard ($id) {
      'Fileset:::*' {
        Write-Verbose -Message 'Loading Fileset API data'
        $uri = ('https://' + $Server + $resources.URI.Fileset) -replace '{id}', $id
      }
      'MssqlDatabase:::*' {
        Write-Verbose -Message 'Loading MSSQL API data'
        $uri = ('https://' + $Server + $resources.URI.MSSQL) -replace '{id}', $id
      }
      'VirtualMachine:::*' {
        Write-Verbose -Message 'Loading VMware API data'
        $uri = ('https://' + $Server + $resources.URI.VMware) -replace '{id}', $id
      }
      'HypervVirtualMachine:::*' {
        Write-Verbose -Message 'Loading HyperV API data'
        $uri = ('https://' + $Server + $resources.URI.HyperV) -replace '{id}', $id
      }
      'ManagedVolume:::*' {
        Write-Verbose -Message 'Loading Managed Volume API data'
        $uri = ('https://' + $Server + $resources.URI.ManagedVolume) -replace '{id}', $id
      }
      'NutanixVirtualMachine:::*' {
        Write-Verbose -Message 'Loading Nutanix API data'
        $uri = ('https://' + $Server + $resources.URI.Nutanix) -replace '{id}', $id
      }
      'VolumeGroup:::*' {
        Write-Verbose -Message 'Loading VolumeGroup API data'
        $uri = ('https://' + $Server + $resources.URI.VolumeGroup) -replace '{id}', $id
      }
      'OracleDatabase:::*' {
        Write-Verbose -Message 'Loading OracleDatabase API data'
        $uri = ('https://' + $Server + $resources.URI.Oracle) -replace '{id}', $id
      }
      'VcdVapp::*' {
        Write-Verbose -Message 'Loading vCD API data'
        $uri = ('https://' + $Server + $resources.URI.VcdVapp) -replace '{id}', $id
      }
      default {
        throw 'The supplied id value has no matching endpoint'
      }
    }
    
    # This ends the logic statement without running the rest of this private function
    return $uri
  }

  Write-Verbose -Message "Build the query parameters for $(if ($querykeys){$querykeys -join ','}else{'<null>'})"
  $querystring = @()
  # Walk through all of the available query options presented by the endpoint
  # Note: Keys are used to search in case the value changes in the future across different API versions
  foreach ($query in $querykeys) {
    # Walk through all of the parameters defined in the function
    # Both the parameter name and parameter alias are used to match against a query option
    # It is suggested to make the parameter name "human friendly" and set an alias corresponding to the query option name
    foreach ($param in $parameters) {
      # If the parameter name matches the query option name, build a query string
      if ($param.Name -eq $query) {
        if ((Get-Variable -Name $param.Name).Value) {
          Write-Debug ('Building Query with "{0}: {1}"' -f $resources.Query[$param.Name], (Get-Variable -Name $param.Name).Value)
        }
        $querystring += Test-QueryObject -object (Get-Variable -Name $param.Name).Value -location $resources.Query[$param.Name] -params $querystring
      }
      # If the parameter alias matches the query option name, build a query string
      elseif ($param.Aliases -eq $query) {
        if ((Get-Variable -Name $param.Name).Value) {
          Write-Debug ('Building Query with "{0}: {1}"' -f (-join $resources.Query[$param.Aliases]), (Get-Variable -Name $param.Name).Value)
        }
        $querystring += Test-QueryObject -object (Get-Variable -Name $param.Name).Value -location $resources.Query[$param.Aliases] -params $querystring
      }
    }
  }
  # After all query options are exhausted, build a new URI with all defined query options
  
  if ($parameters.name -contains 'limit') {
    $uri = New-QueryString -query $querystring -uri $uri
  } elseif ($resource.method -ne 'Get') {
    $uri = New-QueryString -query $querystring -uri $uri
  } else {  
    $uri = New-QueryString -query $querystring -uri $uri -nolimit $true
  }
  Write-Verbose -Message "URI = $uri"
    
  return $uri
}
