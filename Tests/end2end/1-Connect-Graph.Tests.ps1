BeforeAll -Scriptblock {
	.  ./TeamsTools/Classes/AuthApp.ps1
}

Describe "TeamsTools Module Load Test" {
	It "Should import the TeamsTools module without error" {
		{ Import-Module ./teamsTools/ -Force -Verbose } | Should -Not -Throw
	}
}

Describe "TeamsTools Module Load Test" {
	It "Should import the TeamsTools module without error" {
		{ Import-Module ./teamsTools/ -Force -Verbose } | Should -Not -Throw
	}
}

Describe "TeamsTools Graph Connection Tests" {
	
	Context "When disconnected from Graph" {
		
		BeforeAll {
			# Ensure we start disconnected
			Disconnect-TeamsToolsGraph
		}
		
		It "Should show warning when disconnecting while already disconnected" {
			# Expected Result: "WARNING: Disconnection not required: No active connection to Microsoft Graph."
			{ Disconnect-TeamsToolsGraph } | Should -Not -Throw
		}
		
		It "Should require authentication when getting Graph info while disconnected" {
			# Expected Result: Error Message to authenticate
			{ Get-TeamsToolsGraph } | Should -Throw
		}
		
		It "Should require authentication when getting Graph info with invalid domain" {
			{ Get-TeamsToolsGraph -domain "notRealDomain" } | Should -Throw
		}
		
		It "Should require authentication when getting Graph info with invalid tenant ID" {
			{ Get-TeamsToolsGraph -tenantID "notRealTenantID" } | Should -Throw
		}
		
		It "Should return false when testing Graph connection while disconnected" {
			Test-TeamsToolsGraph | Should -Be $false
		}
		
		It "Should return false when testing Graph connection with invalid domain" {
			Test-TeamsToolsGraph -domain "notRealDomain" | Should -Be $false
		}
		
		It "Should return false when testing Graph connection with invalid tenant ID" {
			Test-TeamsToolsGraph -tenantID "notRealTenantID" | Should -Be $false
		}
	}
	
	Context "Graph Connection Scenarios" -Skip {
		# These tests are skipped by default as they require interactive authentication
		
		It "Should connect using device code with specific scopes" {
			{ Connect-TeamsToolsGraph -scopes "Application.Read.All","User.Read.All" -useDeviceCode } | Should -Not -Throw
			Test-TeamsToolsGraph | Should -Be $true
			Disconnect-TeamsToolsGraph
		}
		
		It "Should connect with specific scopes (interactive)" {
			{ Connect-TeamsToolsGraph -scopes "Application.Read.All","User.Read.All" } | Should -Not -Throw
			Test-TeamsToolsGraph | Should -Be $true
			Disconnect-TeamsToolsGraph
		}
		
		It "Should connect using device code with default scopes" {
			{ Connect-TeamsToolsGraph -useDeviceCode } | Should -Not -Throw
			Test-TeamsToolsGraph | Should -Be $true
			Disconnect-TeamsToolsGraph
		}
		
		It "Should connect with default settings" {
			{ Connect-TeamsToolsGraph } | Should -Not -Throw
			Test-TeamsToolsGraph | Should -Be $true
		}
	}
	
	Context "When connected to Graph" -Skip {
		# These tests are skipped by default as they require authentication
		
		BeforeAll {
			# Connect to Graph for these tests
			Connect-TeamsToolsGraph
		}
		
		AfterAll {
			# Clean up connection
			Disconnect-TeamsToolsGraph
		}
		
		It "Should return true when testing Graph connection" {
			Test-TeamsToolsGraph | Should -Be $true
		}
		
		It "Should return true when testing with valid domain" {
			$tenant = (Test-TeamsToolsGraph).tenant
			if ($tenant) {
				Test-TeamsToolsGraph -domain $tenant | Should -Be $true
			} else {
				Set-ItResult -Skipped -Because "No tenant information available"
			}
		}
		
		It "Should return true when testing with valid tenant ID" {
			$tenantID = (Test-TeamsToolsGraph).tenantID
			if ($tenantID) {
				Test-TeamsToolsGraph -tenantID $tenantID | Should -Be $true
			} else {
				Set-ItResult -Skipped -Because "No tenant ID available"
			}
		}
		
		It "Should return false when testing with invalid domain" {
			Test-TeamsToolsGraph -domain "notRealDomain" | Should -Be $false
		}
		
		It "Should return false when testing with invalid tenant ID" {
			Test-TeamsToolsGraph -tenantID "notRealTenantID" | Should -Be $false
		}
		
		It "Should get Graph information successfully" {
			{ Get-TeamsToolsGraph } | Should -Not -Throw
		}
		
		It "Should get Graph information with valid domain" {
			$tenant = (Test-TeamsToolsGraph).tenant
			if ($tenant) {
				{ Get-TeamsToolsGraph -domain $tenant } | Should -Not -Throw
			} else {
				Set-ItResult -Skipped -Because "No tenant information available"
			}
		}
		
		It "Should get Graph information with valid tenant ID" {
			$tenantID = (Test-TeamsToolsGraph).tenantID
			if ($tenantID) {
				{ Get-TeamsToolsGraph -tenantID $tenantID } | Should -Not -Throw
			} else {
				Set-ItResult -Skipped -Because "No tenant ID available"
			}
		}
		
		It "Should handle invalid domain gracefully" {
			{ Get-TeamsToolsGraph -domain "notRealDomain" } | Should -Throw
		}
		
		It "Should handle invalid tenant ID gracefully" {
			{ Get-TeamsToolsGraph -tenantID "notRealTenantID" } | Should -Throw
		}
	}
}