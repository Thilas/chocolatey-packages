# Get-File tests

$expected1 = 'C:\Program Files\???\???.exe'
$expected2 = 'C:\Program Files (x86)\???\???.exe'

$result = [ordered] @{
    A1 = $(Get-File "'$expected1'") -eq $expected1
    A2 = $(Get-File """$expected1""") -eq $expected1
    A3 = $(Get-File $expected1) -eq $expected1

    B1 = $(Get-File "'$expected1' -Test") -eq $expected1
    B2 = $(Get-File """$expected1"" -Test") -eq $expected1
    B3 = $null -eq $(Get-File "$expected1 -Test")

    C1 = $(Get-File "'$expected2'") -eq $expected2
    C2 = $(Get-File """$expected2""") -eq $expected2
    C3 = $(Get-File $expected2) -eq $expected2

    D1 = $(Get-File "'$expected2' -Test") -eq $expected2
    D2 = $(Get-File """$expected2"" -Test") -eq $expected2
    D3 = $null -eq $(Get-File "$expected2 -Test")

    Z1 = $null -eq $(Get-File)
    Z2 = $null -eq $(Get-File '')
    Z3 = $null -eq $(Get-File 'C:\Fake\Path')
}
$result
