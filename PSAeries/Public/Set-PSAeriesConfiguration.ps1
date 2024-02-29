Function Set-SPSAeriesConfiguration{
    <#
    .SYNOPSIS
        Set the configuration to use for the SPSAeries Module
    .DESCRIPTION
        Set the configuration to use for the SPSAeries Module
    .EXAMPLE
        Set-SPSAeriesConfiguration -Name SchoolName
        Set the configuration to SchoolName
    .PARAMETER
    .INPUTS
    .OUTPUTS
    .NOTES
    .LINK
    #>
        [CmdletBinding()] #Enable all the default paramters, including -Verbose
        Param(
            [Parameter(Mandatory=$true,
                ValueFromPipeline=$true,
                ValueFromPipelineByPropertyName=$true,
                # HelpMessage='HelpMessage',
                Position=0)]
            [String]$Name
        )
    
        Begin{
            Write-Verbose -Message "Starting $($MyInvocation.InvocationName) with $($PsCmdlet.ParameterSetName) parameterset..."
            Write-Verbose -Message "Parameters are $($PSBoundParameters | Select-Object -Property *)"
            
        }
        Process{
            try{
                Write-Verbose -Message "Changing Config from $($Script:SPSAeriesConfigName) to $($Name)"
                $Script:SPSAeriesConfigName = $Name

                $Script:SPSAeriesConfigDir = "$Env:USERPROFILE\AppData\Local\powershell\SPSAeries\$Name"
                Write-Verbose -Message "Config dir: $SPSAeriesConfigDir"

                $Script:Config = Get-Content -Raw -Path "$Script:SPSAeriesConfigDir\config.json" | ConvertFrom-Json
                Write-Verbose -Message "Importing config.json"

                $Script:APIKey = Import-Clixml -Path "$Script:SPSAeriesConfigDir\apikey.xml"
                Write-Verbose -Message "Importing apikey.xml"

                $Script:SQLCreds = Import-Clixml -Path "$Script:SPSAeriesConfigDir\sqlcreds.xml"
                Write-Verbose -Message "Importing sqlcreds.xml"
            }
            catch{
                Write-Error -Message "$_ went wrong."
            }
            
            
            
        }
        End{
            Write-Verbose -Message "Ending $($MyInvocation.InvocationName)..."
        }
    }