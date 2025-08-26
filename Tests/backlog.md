# TeamsTools Testing Backlog

## Overview
This backlog contains all the testing improvements needed to make the TeamsTools module production-ready with comprehensive automated testing coverage.

## Current State
- ✅ **Integration Tests**: Manual test scenarios exist for end-to-end workflows
- ❌ **Unit Tests**: Missing automated unit tests for individual functions
- ❌ **Class Tests**: No tests for PowerShell classes
- ❌ **Mock Tests**: No isolation testing with mocked dependencies
- ❌ **CI/CD Integration**: No automated test runner

---

## High Priority Items

### 1. **Pester Unit Tests Framework** 
**Status**: Not Started  
**Effort**: Medium  
**Description**: Set up Pester testing framework and create basic unit tests

**Tasks**:
- [ ] Install/configure Pester module
- [ ] Create test structure (`Tests/Unit/`, `Tests/Integration/`)
- [ ] Create sample unit test for one function
- [ ] Document testing standards and conventions

**Example Structure**:
```
Tests/
├── Unit/
│   ├── Classes/
│   ├── Public/
│   │   ├── AuthApp/
│   │   ├── Domain/  
│   │   ├── Graph/
│   │   └── VirtualTopology/
│   └── Private/
├── Integration/
└── Fixtures/
```

### 2. **Class Testing**
**Status**: Not Started  
**Effort**: Medium  
**Description**: Create comprehensive tests for all PowerShell classes

**Classes to Test**:
- [ ] `authApp` - Constructor validation, property validation
- [ ] `VirtualTopology` - Object creation, collections, methods
- [ ] `VirtualUser` - Property validation, voice status logic
- [ ] `VirtualVoiceRoute` - Priority validation, gateway lists
- [ ] `VirtualPstnGateway` - FQDN validation, port ranges
- [ ] `VirtualDialPlan` - Identity patterns, external access
- [ ] `VirtualNetworkSite/Subnet` - Network validation
- [ ] `DnsRecord` - DNS record type validation
- [ ] `defaultVoiceRoute/NormalisationRule` - Pattern validation

**Example Test**:
```powershell
Describe "authApp Class" {
    It "Should create authApp with valid parameters" {
        $clientSecret = ConvertTo-SecureString "secret" -AsPlainText -Force
        $auth = [authApp]::new("client123", $clientSecret, "tenant456")
        
        $auth.ClientID | Should -Be "client123"
        $auth.TenantID | Should -Be "tenant456"
    }
    
    It "Should validate ClientID is not null" {
        { [authApp]::new("", $null, "tenant") } | Should -Throw
    }
}
```

### 3. **Parameter Validation Tests**
**Status**: Not Started  
**Effort**: High  
**Description**: Test input validation for all public functions

**Functions to Test**:
- [ ] `Add-TeamsDomain` - Domain name validation
- [ ] `New-TeamsToolsAuthApp` - Display name validation  
- [ ] `Connect-TeamsTools` - Credential validation
- [ ] `Add-TeamsVirtualPstnGateway` - FQDN/port validation
- [ ] `Add-TeamsVirtualUser` - UPN/phone number validation
- [ ] `Add-TeamsVirtualVoiceRoute` - Number pattern validation
- [ ] All `Add-TeamsVirtual*` functions - Identity patterns

**Example Test**:
```powershell
Describe "Add-TeamsDomain Parameter Validation" {
    It "Should reject invalid domain names" {
        { Add-TeamsDomain -Domain "invalid..domain" } | Should -Throw
        { Add-TeamsDomain -Domain "domain" } | Should -Throw
        { Add-TeamsDomain -Domain "" } | Should -Throw
    }
    
    It "Should accept valid domain names" {
        Mock Invoke-MgGraphRequest { return @{ id = "test" } }
        { Add-TeamsDomain -Domain "valid.domain.com" } | Should -Not -Throw
    }
}
```

---

## Medium Priority Items

### 4. **Mock Tests for External Dependencies**
**Status**: Not Started  
**Effort**: High  
**Description**: Create isolated tests that don't require real API connections

**Dependencies to Mock**:
- [ ] Microsoft Graph API calls (`Invoke-MgGraphRequest`)
- [ ] Microsoft Teams PowerShell cmdlets
- [ ] File system operations
- [ ] Web requests
- [ ] Authentication flows

**Example Test**:
```powershell
Describe "Connect-TeamsTools" {
    It "Should connect with valid credentials" {
        Mock Connect-MgGraph { return $true }
        Mock Get-MgContext { return @{ TenantId = "test-tenant" } }
        
        $result = Connect-TeamsTools -ClientId "test" -TenantId "test"
        
        Assert-MockCalled Connect-MgGraph -Times 1
        $result | Should -Be $true
    }
    
    It "Should handle authentication failures" {
        Mock Connect-MgGraph { throw "Authentication failed" }
        
        { Connect-TeamsTools -ClientId "invalid" -TenantId "test" } | Should -Throw "Authentication failed"
    }
}
```

### 5. **Error Handling Tests**
**Status**: Not Started  
**Effort**: Medium  
**Description**: Test failure scenarios and error handling

**Error Scenarios to Test**:
- [ ] Graph API failures (network, permissions, throttling)
- [ ] Invalid credentials/authentication failures
- [ ] Missing required modules
- [ ] File system errors (permissions, disk space)
- [ ] Malformed input data
- [ ] Resource not found scenarios
- [ ] Concurrent modification conflicts

**Example Test**:
```powershell
Describe "Error Handling" {
    Context "When Graph API fails" {
        It "Should handle network errors gracefully" {
            Mock Invoke-MgGraphRequest { throw "Network error" }
            
            { Get-TeamsToolsGraph } | Should -Throw "Network error"
        }
        
        It "Should handle permission errors" {
            Mock Invoke-MgGraphRequest { throw "Insufficient privileges" }
            
            $result = Get-TeamsToolsGraph -ErrorAction SilentlyContinue
            $result | Should -BeNullOrEmpty
        }
    }
}
```

### 6. **Helper Functions and Test Fixtures**
**Status**: Not Started  
**Effort**: Medium  
**Description**: Create reusable test data and helper functions

**Fixtures Needed**:
- [ ] Sample auth app objects
- [ ] Mock Graph API responses
- [ ] Virtual topology test data
- [ ] DNS record samples
- [ ] User account test data
- [ ] Voice route/gateway samples

**Example Fixture**:
```powershell
# Tests/Fixtures/SampleData.ps1
function Get-SampleAuthApp {
    return @{
        ClientID = "12345678-1234-1234-1234-123456789012"
        TenantID = "87654321-4321-4321-4321-210987654321"
        DisplayName = "TestApp"
        SecretText = "test-secret"
    }
}

function Get-SampleVirtualTopology {
    $topology = [VirtualTopology]::new("test.domain.com")
    # Add sample data...
    return $topology
}
```

### 7. **Integration Test Improvements**
**Status**: Partially Complete  
**Effort**: Medium  
**Description**: Enhance existing integration tests

**Improvements Needed**:
- [ ] Convert manual tests to automated Pester tests
- [ ] Add assertions and validation
- [ ] Create setup/teardown procedures
- [ ] Add test data validation
- [ ] Improve error reporting
- [ ] Add test isolation

**Example Enhanced Test**:
```powershell
Describe "End-to-End Teams Configuration" {
    BeforeAll {
        # Setup test tenant
        Import-Module ./teamsTools -Force
        $testAuth = Get-TestAuthentication
        Connect-TeamsTools @testAuth
    }
    
    It "Should create complete virtual topology" {
        # Arrange
        New-TeamsVirtualTopology -Domain "test.domain.com"
        
        # Act
        Add-TeamsVirtualNetworkRegion -NetworkRegionID "TestRegion"
        Add-TeamsVirtualNetworkSite -NetworkSiteID "TestSite" -NetworkRegionID "TestRegion"
        
        # Assert
        $regions = Get-TeamsVirtualNetworkRegion
        $regions | Should -HaveCount 1
        $regions[0].NetworkRegionId | Should -Be "TestRegion"
    }
    
    AfterAll {
        # Cleanup
        Disconnect-TeamsTools
    }
}
```

---

## Low Priority Items

### 8. **Performance Tests**
**Status**: Not Started  
**Effort**: Low  
**Description**: Test performance with large datasets

**Tests Needed**:
- [ ] Large virtual topology creation (1000+ objects)
- [ ] Bulk user operations
- [ ] Memory usage during large operations
- [ ] API rate limiting handling
- [ ] Concurrent operations

### 9. **Security Tests**
**Status**: Not Started  
**Effort**: Medium  
**Description**: Test security aspects of the module

**Security Areas**:
- [ ] Credential storage and handling
- [ ] SecureString usage
- [ ] File permissions for auth files
- [ ] API key/secret protection
- [ ] Input sanitization
- [ ] Injection attack prevention

### 10. **Documentation Tests**
**Status**: Not Started  
**Effort**: Low  
**Description**: Ensure all functions have complete help

**Documentation Checks**:
- [ ] All functions have `.SYNOPSIS`
- [ ] All parameters documented
- [ ] Examples provided
- [ ] Links to related functions
- [ ] Help accuracy validation

---

## CI/CD Integration

### 11. **Automated Test Runner**
**Status**: Not Started  
**Effort**: Medium  
**Description**: Set up automated testing pipeline

**Components**:
- [ ] `Tests/RunAllTests.ps1` - Main test runner
- [ ] GitHub Actions workflow
- [ ] Test result reporting
- [ ] Code coverage analysis
- [ ] Failure notifications

**Example Test Runner**:
```powershell
# Tests/RunAllTests.ps1
param(
    [string]$TestType = "All", # Unit, Integration, All
    [string]$OutputPath = "./TestResults"
)

$testPath = switch ($TestType) {
    "Unit" { "./Tests/Unit" }
    "Integration" { "./Tests/Integration" }
    "All" { "./Tests" }
}

$testResults = Invoke-Pester -Path $testPath -OutputFormat NUnitXml -OutputFile "$OutputPath/TestResults.xml" -PassThru

if ($testResults.FailedCount -gt 0) {
    Write-Error "$($testResults.FailedCount) tests failed"
    exit 1
}

Write-Host "All tests passed! ($($testResults.PassedCount) passed)"
```

### 12. **Test Configuration**
**Status**: Not Started  
**Effort**: Low  
**Description**: Configuration files for different test environments

**Config Files Needed**:
- [ ] `Tests/TestSettings.json` - Test configuration
- [ ] `Tests/MockData.json` - Mock API responses
- [ ] `Tests/.gitignore` - Exclude test artifacts
- [ ] Test environment variables

---

## Success Criteria

### **Phase 1** (High Priority Complete)
- [ ] Pester framework installed and configured
- [ ] All classes have basic unit tests
- [ ] Parameter validation tests for all public functions
- [ ] At least 70% code coverage

### **Phase 2** (Medium Priority Complete)
- [ ] All external dependencies mocked
- [ ] Comprehensive error handling tests
- [ ] Test fixtures and helpers created
- [ ] Enhanced integration tests
- [ ] At least 85% code coverage

### **Phase 3** (Low Priority Complete)
- [ ] Performance tests implemented
- [ ] Security tests complete
- [ ] Documentation tests automated
- [ ] Full CI/CD pipeline operational
- [ ] 95%+ code coverage

---

## Notes

### **Current Test Files** (Keep These)
- `1-Connect-Graph.ps1` - Manual Graph connection testing
- `2-Create-AuthApp.ps1` - AuthApp creation workflow
- `3-Connect-AuthApp.ps1` - Authentication workflow
- `4-AddDomain.ps1` - Domain management workflow
- `4-UpdateUsers.ps1` - User update procedures
- `5-Configure-Teams.ps1` - Full Teams configuration
- `6-importfrom-Tenant.ps1` - Tenant import/export
- `99-ResetTenant.ps1` - Cleanup procedures

These files are valuable integration tests and should be kept as reference implementations and manual testing procedures.

### **Test Data Management**
- Use consistent test data across all tests
- Create cleanup procedures for integration tests
- Use test-specific prefixes to avoid conflicts
- Document any external dependencies (test tenants, etc.)

### **Best Practices**
- Follow AAA pattern (Arrange, Act, Assert)
- Use descriptive test names
- Keep tests independent and isolated
- Mock external dependencies
- Test both success and failure scenarios
- Include edge cases and boundary conditions
