


New-CsOnlineDirectRoutingTelephoneNumberUploadOrder -StartingNumber "+61770107000" -EndingNumber "+61770107019"
New-CsOnlineDirectRoutingTelephoneNumberUploadOrder -StartingNumber "+61770108000" -EndingNumber "+61770108019"
New-CsOnlineDirectRoutingTelephoneNumberUploadOrder -TelephoneNumber "+61770106000,+61770106001,+61770106002,+61770106003,+61770106004,+61770106005,+61770106006,+61770106007,+61770106008,+61770106009"


$numbers = get-csphonenumberassignment 7
foreach ($number in $numbers) {
    $number 
    remove-csonlinetelephonenumber -telephoneNumber $number.TelephoneNumber
}