$exCredentials = (Get-Credential ( [Environment]::UserDomainName + '\' + [Environment]::UserName ) )
$exExServer = '<exchangeserverfqdn>'

# Getting existing PowerShell remoting sessions and imported modules, and removing them and imported modules to prevent cmdlet clobbering.
Get-PSSession | Remove-PSSession
Get-Module | Where-Object { $_.Name -like '*tmp*' } | Remove-Module -Confirm:$false

# Creating a new PowerShell Remoting Session.
$exSession = New-PSSession –ConfigurationName Microsoft.Exchange –ConnectionUri ( 'http://' + $exServer + '/PowerShell/?SerializationLevel=Full' ) -Credential $exCredentials –Authentication Kerberos

# Importing the new PowerShell Remoting Session to make the cmdlets locally available.
Import-PSSession $exSession
