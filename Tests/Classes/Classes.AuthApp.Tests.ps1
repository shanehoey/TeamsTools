 # Combined AuthApp Class Tests (Simple + Detailed)
 
BeforeAll -Scriptblock {
	.  ./TeamsTools/Classes/AuthApp.ps1
}

Describe "AuthApp Class Tests" {
    # Simple tests
    It "Can create an empty authApp" {
        $auth = [authApp]::new()
        $auth | Should -Not -BeNullOrEmpty
        $auth.GetType().Name | Should -Be "authApp"
    }
    It "Can create authApp with parameters" {
        $secret = ConvertTo-SecureString "mysecret" -AsPlainText -Force
        $auth = [authApp]::new("client123", $secret, "tenant456")
        $auth.ClientID | Should -Be "client123"
        $auth.TenantID | Should -Be "tenant456"
        $auth.ClientSecret | Should -Not -BeNullOrEmpty
    }
    It "Can set properties after creation" {
        $auth = [authApp]::new()
        $secret = ConvertTo-SecureString "newsecret" -AsPlainText -Force
        $auth.ClientID = "newclient"
        $auth.TenantID = "newtenant"
        $auth.ClientSecret = $secret
        $auth.ClientID | Should -Be "newclient"
        $auth.TenantID | Should -Be "newtenant"
        $auth.ClientSecret | Should -Not -BeNullOrEmpty
    }

    # Detailed tests
    Context "Constructor Tests" {
        It "Should create empty authApp with default constructor" {
            $auth = [authApp]::new()
            $auth | Should -Not -BeNullOrEmpty
            $auth.GetType().Name | Should -Be "authApp"
            $auth.ClientID | Should -BeNullOrEmpty
            $auth.TenantID | Should -BeNullOrEmpty
            $auth.ClientSecret | Should -BeNullOrEmpty
        }
        It "Should create authApp with parameterized constructor" {
            $secret = ConvertTo-SecureString "MySecretValue123" -AsPlainText -Force
            $auth = [authApp]::new("12345678-1234-1234-1234-123456789012", $secret, "87654321-4321-4321-4321-210987654321")
            $auth.ClientID | Should -Be "12345678-1234-1234-1234-123456789012"
            $auth.TenantID | Should -Be "87654321-4321-4321-4321-210987654321"
            $auth.ClientSecret | Should -Not -BeNullOrEmpty
            $auth.ClientSecret.GetType().Name | Should -Be "SecureString"
        }
    }
    Context "Property Validation Tests" {
        It "Should validate ClientID is not null or empty" {
            $auth = [authApp]::new()
            $secret = ConvertTo-SecureString "secret" -AsPlainText -Force
            $auth.ClientID = "valid-client-id"
            $auth.ClientID | Should -Be "valid-client-id"
            { $auth.ClientID = "" } | Should -Throw
        }
        It "Should validate TenantID is not null or empty" {
            $auth = [authApp]::new()
            $auth.TenantID = "valid-tenant-id"
            $auth.TenantID | Should -Be "valid-tenant-id"
            { $auth.TenantID = "" } | Should -Throw
        }
        It "Should validate ClientSecret is not null or empty" {
            $auth = [authApp]::new()
            $secret = ConvertTo-SecureString "mysecret" -AsPlainText -Force
            $auth.ClientSecret = $secret
            $auth.ClientSecret | Should -Not -BeNullOrEmpty
            $auth.ClientSecret.GetType().Name | Should -Be "SecureString"
            { $auth.ClientSecret = $null } | Should -Throw
        }
    }
    Context "Property Assignment Tests" {
        It "Should allow modifying properties after creation" {
            $secret1 = ConvertTo-SecureString "secret1" -AsPlainText -Force
            $secret2 = ConvertTo-SecureString "secret2" -AsPlainText -Force
            $auth = [authApp]::new("client1", $secret1, "tenant1")
            $auth.ClientID = "client2"
            $auth.TenantID = "tenant2"
            $auth.ClientSecret = $secret2
            $auth.ClientID | Should -Be "client2"
            $auth.TenantID | Should -Be "tenant2"
            $auth.ClientSecret | Should -Be $secret2
        }
    }
    Context "Type Validation Tests" {
        It "Should enforce SecureString type for ClientSecret" {
            $auth = [authApp]::new()
            $validSecret = ConvertTo-SecureString "mysecret" -AsPlainText -Force
            $auth.ClientSecret = $validSecret
            $auth.ClientSecret.GetType().Name | Should -Be "SecureString"
            { $auth.ClientSecret = "plain-text-secret" } | Should -Throw
        }
        It "Should enforce String type for ClientID and TenantID" {
            $auth = [authApp]::new()
            $auth.ClientID = "string-value"
            $auth.TenantID = "another-string"
            $auth.ClientID.GetType().Name | Should -Be "String"
            $auth.TenantID.GetType().Name | Should -Be "String"
        }
    }
    Context "Edge Case Tests" {
        It "Should handle GUID-format strings for ClientID and TenantID" {
            $auth = [authApp]::new()
            $secret = ConvertTo-SecureString "secret" -AsPlainText -Force
            $guidFormat1 = "12345678-1234-1234-1234-123456789012"
            $guidFormat2 = "87654321-4321-4321-4321-210987654321"
            $auth.ClientID = $guidFormat1
            $auth.TenantID = $guidFormat2
            $auth.ClientSecret = $secret
            $auth.ClientID | Should -Be $guidFormat1
            $auth.TenantID | Should -Be $guidFormat2
        }
        It "Should handle long strings for IDs" {
            $auth = [authApp]::new()
            $longString = "a" * 100
            $auth.ClientID = $longString
            $auth.TenantID = $longString
            $auth.ClientID | Should -Be $longString
            $auth.TenantID | Should -Be $longString
            $auth.ClientID.Length | Should -Be 100
        }
        It "Should handle complex SecureString scenarios" {
            $auth = [authApp]::new()
            $emptySecret = ConvertTo-SecureString "" -AsPlainText -Force
            $longSecret = ConvertTo-SecureString ("x" * 256) -AsPlainText -Force
            $specialCharsSecret = ConvertTo-SecureString "!@#$%^&*()_+-=" -AsPlainText -Force
            try {
                $auth.ClientSecret = $emptySecret
                $auth.ClientSecret | Should -Not -BeNullOrEmpty
            } catch {
                $_.Exception.Message | Should -Match "ValidateNotNullOrEmpty"
            }
            $auth.ClientSecret = $longSecret
            $auth.ClientSecret | Should -Not -BeNullOrEmpty
            $auth.ClientSecret = $specialCharsSecret
            $auth.ClientSecret | Should -Not -BeNullOrEmpty
        }
    }
    Context "Object Behavior Tests" {
        It "Should create independent instances" {
            $secret1 = ConvertTo-SecureString "secret1" -AsPlainText -Force
            $secret2 = ConvertTo-SecureString "secret2" -AsPlainText -Force
            $auth1 = [authApp]::new("client1", $secret1, "tenant1")
            $auth2 = [authApp]::new("client2", $secret2, "tenant2")
            $auth1.ClientID | Should -Not -Be $auth2.ClientID
            $auth1.TenantID | Should -Not -Be $auth2.TenantID
            $auth1.ClientID = "modified-client"
            $auth2.ClientID | Should -Be "client2"
        }
        It "Should support object comparison operations" {
            $secret = ConvertTo-SecureString "secret" -AsPlainText -Force
            $auth1 = [authApp]::new("client1", $secret, "tenant1")
            $auth2 = [authApp]::new("client1", $secret, "tenant1")
            $auth3 = $auth1
            $auth1 -eq $auth3 | Should -Be $true
            $auth1 -eq $auth2 | Should -Be $false
        }
    }
    Context "Integration with PowerShell Features" {
        It "Should work with PowerShell pipeline" {
            $secret = ConvertTo-SecureString "secret" -AsPlainText -Force
            $auth = [authApp]::new("client1", $secret, "tenant1")
            $result = $auth | ForEach-Object { $_.ClientID }
            $result | Should -Be "client1"
        }
        It "Should work with Select-Object" {
            $secret = ConvertTo-SecureString "secret" -AsPlainText -Force
            $auth = [authApp]::new("client1", $secret, "tenant1")
            $selected = $auth | Select-Object ClientID, TenantID
            $selected.ClientID | Should -Be "client1"
            $selected.TenantID | Should -Be "tenant1"
        }
        It "Should serialize to JSON (with SecureString handled)" {
            $secret = ConvertTo-SecureString "secret" -AsPlainText -Force
            $auth = [authApp]::new("client1", $secret, "tenant1")
            $json = $auth | ConvertTo-Json -ErrorAction SilentlyContinue
            $json | Should -Not -BeNullOrEmpty
        }
    }
}
