<#
    .SYNOPSIS
    Returns the piped object if a specified string property contains any partial value from a list.

    .DESCRIPTION
    The Get-ObjectWithMatchingProperty function takes in a list (SourceList) and a string property (Property) from a piped object,
    and checks if any part of the items in SourceList is contained within the string property. 
    If at least one partial match is found, it returns the piped object, otherwise, it returns $null.

    .PARAMETER SourceList
    Specifies the list of values that will be searched for within the string property.

    .PARAMETER Property
    Specifies the property name in the piped object where the search will be performed.

    .INPUTS
    PSCustomObject. You can pipe objects to Get-ObjectWithMatchingProperty.

    .OUTPUTS
    PSCustomObject. Get-ObjectWithMatchingProperty returns the piped object if a match is found.

    .EXAMPLE
    PS> $obj = [PSCustomObject]@{ Name = "apple" }
    PS> $obj | Get-ObjectWithMatchingProperty -SourceList @("app", "cher") -Property "Name"
    @{Name='apple'}

    .EXAMPLE
    PS> $obj = [PSCustomObject]@{ Name = "apple" }
    PS> $obj | Get-ObjectWithMatchingProperty -SourceList @("ora", "lem") -Property "Name"
    $null
#>

function Get-ObjectWithMatchingProperty {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [array]$SourceList,

        [Parameter(Mandatory=$true)]
        [string]$Property,

        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [PSCustomObject]$InputObject
    )

    begin {
        Write-Verbose "Starting Get-ObjectWithMatchingProperty function."
    }

    process {
        $Value = $InputObject.$Property
        foreach ($item in $SourceList) {
            if ($Value -like "*$item*") {
                Write-Verbose "Match found. Returning object."
                return $InputObject
            }
        }
        Write-Verbose "No match found. Returning null."
        return $null
    }

    end {
        Write-Verbose "Ending Get-ObjectWithMatchingProperty function."
    }
}
