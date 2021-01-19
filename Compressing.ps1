## Compressing, archiving

Compress-Archive -Path C:\test -CompressionLevel Optimal -DestinationPath C:\Temp\achive.zip

Compress-Archive -Path C:\test\* -Update -DestinationPath C:\Temp\achive.zip

Expand-Archive -Path C:\Temp\achive.zip -DestinationPath C:\test
