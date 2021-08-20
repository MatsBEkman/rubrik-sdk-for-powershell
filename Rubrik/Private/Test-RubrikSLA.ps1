﻿Function Test-RubrikSLA($SLA, $Inherit, $DoNotProtect, $Mandatory, $PrimaryClusterID) {
  <#
    .SYNOPSIS
    Retrieves an ID for a given SLA

    .DESCRIPTION
    The Test-RubrikSLA function retrieves the ID for a given SLA Domain name

    .PARAMETER SLA
    The SLA Domain name to lookup

    .PARAMETER Inherit
    Switch to set SLA to 'Inherit'

    .PARAMETER DoNotProtect
    Switch to set SLA to 'Unprotected'

    .PARAMETER Mandatory
    Switch to ensure SLA information was inputted

    .PARAMETER PrimaryClusterId
    The ID of the cluster to search
  #>

  Write-Verbose -Message 'Determining the SLA Domain id'
  if ($SLA) {
    $slaid = & {
      $local:PSDefaultParameterValues = @{Disabled=$true}
      if (-not [string]::IsNullOrWhiteSpace($PrimaryClusterID)) {
        $currentId = (Get-RubrikSLA -SLA $SLA -PrimaryClusterID $PrimaryClusterID).id
        if (@($currentId).count -gt 1) {
          Write-Verbose -Message "Multiple SLA ID for '$SLA', limiting query to local cluster"
          (Get-RubrikSLA -SLA $SLA -PrimaryClusterID local).id
        } else {
          $currentId
        }
      } else {
        (Get-RubrikSLA -SLA $SLA).id
      }
    }
    if ($slaid -eq $null) {
      throw "No SLA Domains were found that match '$SLA' for cluster ID '$PrimaryClusterID'"
    }
    return $slaid
  }
  if ($Inherit) {
    return 'INHERIT'
  }
  if ($DoNotProtect) {
    return 'UNPROTECTED'
  }
  if ($Mandatory) {
    throw 'No SLA information was entered.'
  }
}

