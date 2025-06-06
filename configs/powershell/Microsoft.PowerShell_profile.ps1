# Consider placing this profile into ~/Documents/PowerShell

Set-Alias -Name ll -Value ls

# Body of the `prompt` function can be retrieved from within an active shell with
# $ (Get-Command Prompt).ScriptBlock

function prompt {
    write-host "$env:COMPUTERNAME" -ForegroundColor Yellow -NoNewline
    write-host " @ " -NoNewline

    if ((Get-Location).Drive -ne $null) {
        if ((Get-Location).path.Split("\").Count -gt 5) {
            write-host "$((Get-Location).Drive):\...\" -ForegroundColor Green -NoNewline
            write-host "$((Get-Location).path.Split("\")[-1])" -ForegroundColor Green -NoNewline

        } else {
            write-host (Get-Location) -ForegroundColor Green -NoNewline
        }

    # Network Drive
    } else {
        if ((Get-Location).path.Split("\").Count -gt 7) {
            write-host "\\$((Get-Location).path.Split("\")[3])\...\" -ForegroundColor Green -NoNewline
            write-host "$((Get-Location).path.Split("\")[-1])" -ForegroundColor Green -NoNewline

        } else {
            $first, $second, $third, $folder = (Get-Location).path.Split("\")
            write-host "\" -ForegroundColor Green -NoNewline
            $folder | foreach-object {
                write-host "\$_" -ForegroundColor Green -NoNewline
            }
        }
    }

    write-host ">" -ForegroundColor Green -NoNewline
    return " "
}

# To allow profile execution consider running `Set-ExecutionPolicy bypass` in Administrator's PS session
