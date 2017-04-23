#requires -Version 3.0

$ZendeskDomain = 'captosupport.zendesk.com'
$Email = 'alo@capto.dk'
$ZendeskToken = 'Qv6Q4qMzHiBAmJUsZ09e93Zx4EDqxwpGc9iBsQSv'
$PiplToken = 'SOCIAL-PREMIUM-ehu3swfhks51tfu9dn6gwv4f'
 



Set-Variable -Name Headers -Value @{
  Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$($Email)/token:$($ZendeskToken)"))
} -Scope Global



$params = @{
  Uri     = ("https://$ZendeskDomain/api/v2/users.json").TrimEnd('&')
  Method  = 'Get'
  Headers = $Headers
}

$User = ''


Function Update-phonenumber ($ZendeskUsers)
{
  Foreach ($User in $ZendeskUsers.users)
  {
    If ( $User.phone )
    {
      Write-Information -MessageData "Processing $User.name..."
      Write-Information -MessageData $User.phone
      
      $pnum = $User.phone.trim()
      $pnum = $pnum.replace('+45', '')
      $pnum = $pnum.replace(' ', '')
      $pnum = $pnum.trim()
     
      IF ($pnum.Length -eq 8) 
      {
        $User.phone = '+45 ' + [String]::Format('{0:## ## ## ##}',[int]$pnum)
        $User.shared_phone_number = 'False'
      }
    }
      
      
    <#
    }#>
  }
}
$params = @{
  Uri         = ("https://$ZendeskDomain/api/v2/users/update_many.json")
  Method      = 'PUT'
  Headers     = $Headers
  Body        = ($ZendeskUsers | ConvertTo-Json)
  ContentType = 'application/json'
}
      
$result = Invoke-RestMethod @params -Verbose

   
<# If ($ZendeskUsers.next_page) 
    {
    $params = @{
    Uri     = $ZendeskUsers.next_page
    Method  = 'Get'
    Headers = $Headers
    }
    $ZendeskUsers = Invoke-RestMethod @params -Verbose
    Update-phonenumber$use ($ZendeskUsers)
} #>

$ZendeskUsers = Invoke-RestMethod @params -Verbose
Update-phonenumber ($ZendeskUsers)



