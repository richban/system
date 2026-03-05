# setup-wsl-env.ps1
#
# Configures which Windows environment variables are visible inside WSL.
# Run once after any change, then restart WSL:  wsl --shutdown
#
# TWO sections — use either or both:
#
#   Section A: vars ALREADY defined in Windows User env vars.
#              You only list the name here; values stay where they are.
#
#   Section B: vars you want to DEFINE here and keep as a text record.
#              Values are set in Windows AND forwarded to WSL.
#              Useful when there is no other canonical place for them.
#
# After running:
#   wsl --shutdown    (PowerShell)
#   then reopen WSL and verify with:  echo $VAR_NAME

# ===========================================================================
# SECTION A — Forward existing Windows User vars to WSL (names only)
#
# Flags:
#   /u  plain string value  (secrets, IDs, tokens — most common)
#   /p  single Windows path, auto-converted to /mnt/... in WSL
#   /l  list of Windows paths (semicolon-sep → colon-sep in WSL)
# ===========================================================================
$forwardOnly = @(
    "AZURE_CLIENT_ID/u"
    # "AZURE_TENANT_ID/u"
    # "AZURE_SUBSCRIPTION/u"
    # "SOME_WINDOWS_PATH/p"
)

# ===========================================================================
# SECTION B — Define here AND forward to WSL
#
# These are SET as Windows User env vars by this script, so this file
# becomes the single source of truth for their values.
# Do NOT commit this file with real values to a public repo.
# Keep a local copy outside the repo, or use the .gitignore approach.
#
# Format: "VAR_NAME/flag" = "value"
# ===========================================================================
$defineAndForward = [ordered]@{
    # Azure
    # "AZURE_CLIENT_SECRET/u" = "your-client-secret"

    # Other secrets
    # "MY_API_KEY/u"          = "your-api-key"
    # "MY_OTHER_SECRET/u"     = "your-other-secret"
}

# ===========================================================================
# Script logic — no need to edit below this line
# ===========================================================================

function Get-VarName($entry) { $entry -replace "/.*$", "" }
function Get-VarFlag($entry) { if ($entry -match "/(\w+)$") { $Matches[1] } else { "u" } }

$allWslParts = @()

# --- Process Section A ---
Write-Host "`n[Section A] Forwarding existing Windows vars to WSL..." -ForegroundColor Cyan
foreach ($entry in $forwardOnly) {
    $name = Get-VarName $entry
    $value = [System.Environment]::GetEnvironmentVariable($name, "User")
    if ($null -eq $value) {
        Write-Host "  WARN  $name - not found in Windows User env vars, skipping" -ForegroundColor Yellow
    } else {
        Write-Host "  OK    $name" -ForegroundColor Green
        $allWslParts += $entry
    }
}

# --- Process Section B ---
if ($defineAndForward.Count -gt 0) {
    Write-Host "`n[Section B] Setting and forwarding defined vars..." -ForegroundColor Cyan
    foreach ($entry in $defineAndForward.GetEnumerator()) {
        $nameWithFlag = $entry.Key
        $name  = Get-VarName $nameWithFlag
        $value = $entry.Value
        [System.Environment]::SetEnvironmentVariable($name, $value, "User")
        Write-Host "  SET   $name" -ForegroundColor Green
        $allWslParts += $nameWithFlag
    }
} else {
    Write-Host "`n[Section B] No vars defined - skipping." -ForegroundColor DarkGray
}

# --- Write WSLENV ---
if ($allWslParts.Count -eq 0) {
    Write-Host "`nNothing to forward. Add entries to Section A or Section B." -ForegroundColor Yellow
    exit 0
}

$wslenv = $allWslParts -join ":"
[System.Environment]::SetEnvironmentVariable("WSLENV", $wslenv, "User")

Write-Host "`n==> WSLENV = $wslenv" -ForegroundColor Cyan
Write-Host "==> Done. Restart WSL:" -ForegroundColor Yellow
Write-Host "      wsl --shutdown" -ForegroundColor White
Write-Host ""
