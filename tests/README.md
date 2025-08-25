# TeamsTools Test Suite

This directory contains a comprehensive test suite for the TeamsTools PowerShell module, built using the Pester testing framework.

## 📁 Test Structure

```
tests/
├── Unit/                           # Unit tests
│   └── Classes/                    # Class-specific tests
│       ├── authApp.Tests.ps1
│       ├── VirtualTopology.Tests.ps1
│       ├── VirtualUser.Tests.ps1
│       └── ...
├── Integration/                    # Integration tests
│   └── (coming soon)
├── Fixtures/                       # Test data and mock objects
├── Test-Runner.ps1                 # Main test runner script
├── Quick-Test.ps1                  # Quick development test runner
├── run-tests.bat                   # Windows batch runner
├── run-tests.sh                    # Linux/macOS shell runner
├── test-config.yaml               # Test configuration
└── README.md                      # This file
```

## 🚀 Quick Start

### Prerequisites

1. **PowerShell 5.1+** or **PowerShell Core 7.0+**
2. **Pester 5.0+** testing framework

Install Pester if not already installed:
```powershell
Install-Module -Name Pester -Force -SkipPublisherCheck
```

### Running Tests

#### Option 1: PowerShell Script (Recommended)
```powershell
# Run all tests with default settings
./tests/Test-Runner.ps1

# Run only unit tests
./tests/Test-Runner.ps1 -TestType Unit

# Run with detailed output
./tests/Test-Runner.ps1 -Detailed

# Run with code coverage
./tests/Test-Runner.ps1 -CodeCoverage

# Export results to XML
./tests/Test-Runner.ps1 -OutputFormat NUnitXml -OutputPath "./TestResults"
```

#### Option 2: Quick Test (Development)
```powershell
# Fast test run with minimal output
./tests/Quick-Test.ps1

# Test specific file
./tests/Quick-Test.ps1 -Path "Unit/Classes/authApp.Tests.ps1"

# Quick run with failures only
./tests/Quick-Test.ps1 -Quick
```

#### Option 3: Platform Scripts
**Windows (Command Prompt):**
```cmd
cd tests
run-tests.bat
```

**Linux/macOS (Terminal):**
```bash
cd tests
./run-tests.sh
```

## 🧪 Test Categories

Our tests are organized into several categories:

### Unit Tests (`/Unit/`)
- **Class Tests**: Validate individual class constructors, properties, and methods
- **Function Tests**: Test public and private functions
- **Parameter Validation**: Ensure proper input validation
- **Edge Cases**: Test boundary conditions and error scenarios

### Integration Tests (`/Integration/`)
- **Module Integration**: Test how components work together
- **External Dependencies**: Test interactions with Microsoft Teams/Graph APIs
- **End-to-End Scenarios**: Complete workflow testing

## 📊 Test Coverage

We aim for high test coverage across all components:

| Component Type | Target Coverage | Current Status |
|---------------|----------------|----------------|
| Classes       | 90%+           | ✅ Implemented |
| Public Functions | 85%+        | 🚧 In Progress |
| Private Functions | 70%+       | 📋 Planned |
| Integration   | 60%+           | 📋 Planned |

## 🏷️ Test Tags

Tests are tagged for easy filtering:

- `Constructor` - Class constructor tests
- `ParameterValidation` - Input validation tests
- `PropertyTest` - Property getter/setter tests
- `BusinessLogic` - Core functionality tests
- `EdgeCase` - Boundary and error condition tests
- `Emergency` - Emergency calling functionality
- `Performance` - Performance-related tests

### Running Tagged Tests
```powershell
# Run only constructor tests
./tests/Test-Runner.ps1 -Tag "Constructor"

# Exclude edge case tests
./tests/Test-Runner.ps1 -ExcludeTag "EdgeCase"

# Run critical tests only
./tests/Test-Runner.ps1 -Tag "Constructor", "ParameterValidation", "Emergency"
```

## 🔧 Test Runner Options

### Test-Runner.ps1 Parameters

| Parameter | Description | Default | Example |
|-----------|-------------|---------|---------|
| `-TestType` | Which tests to run: Unit, Integration, All | `All` | `-TestType Unit` |
| `-OutputFormat` | Output format: Console, NUnitXml, JUnitXml | `Console` | `-OutputFormat JUnitXml` |
| `-OutputPath` | Where to save test results | `./TestResults` | `-OutputPath "C:\Results"` |
| `-CodeCoverage` | Enable code coverage analysis | `$false` | `-CodeCoverage` |
| `-Detailed` | Show detailed test output | `$false` | `-Detailed` |
| `-Tag` | Run only tests with specific tags | (none) | `-Tag "Constructor"` |
| `-ExcludeTag` | Exclude tests with specific tags | (none) | `-ExcludeTag "EdgeCase"` |
| `-PassThru` | Return Pester result object | `$false` | `-PassThru` |

### Quick-Test.ps1 Parameters

| Parameter | Description | Default | Example |
|-----------|-------------|---------|---------|
| `-Path` | Specific test file or directory | (all tests) | `-Path "Unit\Classes"` |
| `-Quick` | Minimal output (failures only) | `$false` | `-Quick` |

## 🏗️ Writing Tests

### Test File Structure
```powershell
BeforeAll {
    # Import the module
    Import-Module "$PSScriptRoot/../../../teamsTools" -Force
}

Describe "ClassName" {
    Context "Constructor Tests" {
        It "Should create object with valid parameters" {
            # Arrange
            $param1 = "ValidValue"
            
            # Act
            $object = [ClassName]::new($param1)
            
            # Assert
            $object.Property1 | Should -Be $param1
        }
    }
    
    Context "Parameter Validation" {
        It "Should validate required parameters" {
            # Test parameter validation
            { [ClassName]::new("") } | Should -Throw
        }
    }
}
```

### Best Practices

1. **Follow AAA Pattern**: Arrange, Act, Assert
2. **Use Descriptive Names**: Test names should clearly describe what is being tested
3. **Test One Thing**: Each test should verify one specific behavior
4. **Use BeforeEach/AfterEach**: For setup/cleanup when needed
5. **Mock External Dependencies**: Use Pester mocks for external calls
6. **Test Edge Cases**: Include boundary conditions and error scenarios

### Example Test Scenarios

```powershell
# Constructor validation
It "Should create authApp with valid parameters" {
    $clientSecret = ConvertTo-SecureString "secret" -AsPlainText -Force
    $auth = [authApp]::new("client123", $clientSecret, "tenant456")
    
    $auth.ClientID | Should -Be "client123"
    $auth.TenantID | Should -Be "tenant456"
}

# Parameter validation
It "Should validate ClientID is not null" {
    $clientSecret = ConvertTo-SecureString "secret" -AsPlainText -Force
    { [authApp]::new("", $clientSecret, "tenant") } | Should -Throw
}

# Property testing
It "Should allow modification of description" {
    $route = [VirtualVoiceRoute]::new("TestRoute", "^\+\d+$", $usageList, $gatewayList, 100)
    $route.Description = "Test Description"
    $route.Description | Should -Be "Test Description"
}
```

## 📈 Continuous Integration

### GitHub Actions

The repository includes GitHub Actions workflows for automated testing:

- **On Push/PR**: Runs unit tests on Windows, Linux, and macOS
- **Code Coverage**: Generates coverage reports for main/beta branches
- **Integration Tests**: Runs integration tests on main branch

### Local Development

For local development, we recommend:

1. **Run Quick Tests** during development: `./Quick-Test.ps1`
2. **Full Test Suite** before commits: `./Test-Runner.ps1`
3. **Code Coverage** before releases: `./Test-Runner.ps1 -CodeCoverage`

## 🐛 Troubleshooting

### Common Issues

**Pester Not Found:**
```powershell
Install-Module -Name Pester -Force -SkipPublisherCheck
```

**Module Import Errors:**
- Ensure teamsTools module is built and available
- Check that all dependencies are installed
- Verify PowerShell execution policy allows script execution

**Test Timeouts:**
- Integration tests may take longer than unit tests
- Increase timeout values in test-config.yaml if needed

**Permission Errors:**
- Ensure scripts are executable (Linux/macOS): `chmod +x run-tests.sh`
- Check PowerShell execution policy on Windows

### Getting Help

- Review test output for specific failure reasons
- Check the [Issues](../../issues) section for known problems
- Ensure all prerequisites are installed
- Verify network connectivity for integration tests

## 🤝 Contributing

When adding new features or fixing bugs:

1. **Write Tests First**: Follow TDD practices where possible
2. **Maintain Coverage**: Ensure new code has appropriate test coverage
3. **Update Documentation**: Update this README if adding new test categories
4. **Run Full Suite**: Verify all tests pass before submitting PRs

## 📝 Test Results

Test results can be exported in multiple formats for CI/CD integration:

- **Console Output**: Human-readable results for development
- **NUnit XML**: Compatible with most CI/CD systems
- **JUnit XML**: Compatible with Jenkins and other tools
- **JaCoCo XML**: Code coverage format for SonarQube integration

Example CI integration:
```yaml
- name: Run Tests
  run: ./tests/Test-Runner.ps1 -OutputFormat JUnitXml -OutputPath ./TestResults
  
- name: Publish Results
  uses: dorny/test-reporter@v1
  with:
    name: Test Results
    path: 'TestResults/TestResults_*.xml'
    reporter: java-junit
```

---

**Happy Testing!** 🧪✨

For questions or suggestions about the test suite, please open an issue or submit a pull request.
