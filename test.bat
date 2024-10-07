@echo off
setlocal

:: Set the path to the Chrome Bookmarks file
set "bookmarksPath=%LocalAppData%\Google\Chrome\User Data\Default\Bookmarks"
:: Set the new name for the bookmarks
set "newName=NewBookmarkName"

:: Check if the Bookmarks file exists
if not exist "%bookmarksPath%" (
    echo Chrome bookmarks file not found!
    exit /b 1
)

:: Run PowerShell code to update all bookmark names
powershell -Command ^
    $filePath = '%bookmarksPath%'; ^
    $newName = '%niggaballs%'; ^
    $json = Get-Content $filePath -Raw | ConvertFrom-Json; ^
    function Update-BookmarkNames($bookmark) { ^
        if ($bookmark.type -eq 'folder') { ^
            foreach ($child in $bookmark.children) { ^
                Update-BookmarkNames $child ^
            } ^
        } elseif ($bookmark.type -eq 'url') { ^
            $bookmark.name = $newName ^
        } ^
    }; ^
    foreach ($root in $json.roots) { ^
        Update-BookmarkNames $json.roots.$root ^
    }; ^
    $json | ConvertTo-Json -Compress | Set-Content $filePath; ^
    Write-Host "All bookmark names changed to '%niggaballs%%'"

endlocal
