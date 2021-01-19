Import-Module Pester

#Sample function to run tests against    
function Add-Numbers{
    param($a, $b)
    return [int]$a + [int]$b
}

#Group of tests
Describe "Validate Add-Numbers" {

        #Individual test cases
        It "Should add 2 + 2 to equal 4" {
            Add-Numbers 2 2 | Should Be 4
        }

        It "Should handle strings" {
            Add-Numbers "2" "2" | Should Be 4
        }

        It "Should return an integer"{
            Add-Numbers 2.3 2 | Should BeOfType Int32
        }

}


##Creating a new test in Pester is easy. It contains a utility function New-Fixture to create the basic “scaffolding” for a test. Optionally it can create a separate folder to keep our working folder well-organized.
cd C:\Temp\Test
New-Fixture -Path HelloWorldExample -Name Get-HelloWorld
cd .\HelloWorldExample
Dir


