

New-MgGroup -DisplayName "aus07" -MailEnabled:$false -MailNickName "aus07" -SecurityEnabled:$true
New-MgGroup -DisplayName "aus02" -MailEnabled:$false -MailNickName "aus02" -SecurityEnabled:$true
New-MgGroup -DisplayName "aus03" -MailEnabled:$false -MailNickName "aus03" -SecurityEnabled:$true
New-MgGroup -DisplayName "aus08" -MailEnabled:$false -MailNickName "aus08" -SecurityEnabled:$true




# find-csgroup

Find-CsGroup -SearchQuery "aus" -MaxResults 5



# New-CsGroupPolicyAssignment


#TenantDialPlan
New-CsGroupPolicyAssignment -GroupId (Find-CsGroup -SearchQuery "aus07" -MaxResults 1).id -PolicyType TenantDialPlan -PolicyName AU07-DP1
New-CsGroupPolicyAssignment -GroupId (Find-CsGroup -SearchQuery "aus02" -MaxResults 1).id -PolicyType TenantDialPlan -PolicyName au02-dp1
New-CsGroupPolicyAssignment -GroupId (Find-CsGroup -SearchQuery "aus03" -MaxResults 1).id -PolicyType TenantDialPlan -PolicyName au03-dp1
New-CsGroupPolicyAssignment -GroupId (Find-CsGroup -SearchQuery "aus08" -MaxResults 1).id -PolicyType TenantDialPlan -PolicyName au08-dp1
#OnlineVoiceRoutingPolicy
New-CsGroupPolicyAssignment -GroupId (Find-CsGroup -SearchQuery "aus07" -MaxResults 1).id -PolicyType OnlineVoiceRoutingPolicy -PolicyName AU07-National
New-CsGroupPolicyAssignment -GroupId (Find-CsGroup -SearchQuery "aus02" -MaxResults 1).id -PolicyType OnlineVoiceRoutingPolicy -PolicyName au02-National
New-CsGroupPolicyAssignment -GroupId (Find-CsGroup -SearchQuery "aus03" -MaxResults 1).id -PolicyType OnlineVoiceRoutingPolicy -PolicyName au03-National
New-CsGroupPolicyAssignment -GroupId (Find-CsGroup -SearchQuery "aus08" -MaxResults 1).id -PolicyType OnlineVoiceRoutingPolicy -PolicyName au08-National


#SBA  not supported in gui but seems to work 
New-CsGroupPolicyAssignment -GroupId (Find-CsGroup -SearchQuery "aus07" -MaxResults 1).id -PolicyType TeamsSurvivableBranchAppliancePolicy -PolicyName SBA

#TODO TeamsSyntheticAutomatedCallPolicy
#TODO TeamsEmergencyCallingPolicy
#TODO TeamsEmergencyCallRoutingPolicy
#TODO TeamsSharedCallingRoutingPolicy
#TODO TeamsIPPhonePolicy

#TODO TeamsCallingPolicy
#TODO TEAMSCallholdPolicy
#TODO TeamsCallParkPolicy

#TODO TeamsCallerID  Policy   not sure of the name 

#TODO OblineDialOutPolicy
#TODO TeamsMeetingPolicy
#TODO  Teams MobilityPolicy
#TODO TeamsVoicemailPolicy

# Get-CsGroupPolicyAssignment

Get-CsGroupPolicyAssignment

# Grant-CsGroupPolicyPackageAssignment




# Remove-CsGroupPolicyAssignment





