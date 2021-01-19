### Simple progressBar - gagyi
1..100 | ForEach-Object {
        Write-Progress -Activity "Copying files" -Status "$_ %" -Id 1 -PercentComplete $_ -CurrentOperation "Copying file file_name_$_.txt"
        Start-Sleep -Milliseconds 500    # sleep simulates working code, replace this line with your executive code (i.e. file copying)
    }

####################################
## Inner progressbar
1..10 | foreach-object {
        $fileName = "file_name_$_.txt"
        Write-Progress -Activity "Copying files" -Status "$($_*10) %" -Id 1 -PercentComplete ($_*10) -CurrentOperation "Copying file $fileName"
            
        1..100 | foreach-object {
            Write-Progress -Activity "Copying contents of the file $fileName" -Status "$_ %" -Id 2 -ParentId 1 -PercentComplete $_ -CurrentOperation "Copying $_. line"
            
            Start-Sleep -Milliseconds 20 # sleep simulates working code, replace this line with your executive code (i.e. file copying)
        }

        Start-Sleep -Milliseconds 500 # sleep simulates working code, replace this line with your executive code (i.e. file search)

   }