# Set to true if you want to show all the users
$allusers = $false

# Get all AD user objects
$userData = (get-aduser -filter * -Properties *)

foreach ($u in $userData) {

    # Check if DONT_REQ_PREAUTH is enabled, following: https://learn.microsoft.com/es-es/troubleshoot/windows-server/identity/useraccountcontrol-manipulate-account-properties
    if ([bool]($u.userAccountControl -band 4194304)) {
        # Look at those prints!
        write-host -NoNewline ">>>>: "
        write-host -NoNewline -ForegroundColor RED ($u).SamAccountName
        write-host " located on"$u.DistinguishedName"is vulnerable to ASREPRoast"

    } elseif ($allusers) {
        # Look!
        write-host -NoNewline "User: "
        write-host -ForegroundColor GREEN ($u).SamAccountName"located on"$u.DistinguishedName"is NOT vulnerable to ASREPRoast"
    }
}
