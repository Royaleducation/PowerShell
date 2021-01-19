## RESTful - Define your payload to send for possible more complex data
$Payload = @{ text="test string"; username="testuser" }
Invoke-RestMethod -Uri "https://hooks.slack.com/services/yourwebhookstring" -Method Post -Body (ConvertTo-Json $Payload)

## GET your REST data and store in a PowerShell object:
$Post = Invoke-RestMethod -Uri "http://jsonplaceholder.typicode.com/posts/1"## Modify your data:$Post.title = "New Title2"##PUT the REST data back$Json = $Post | ConvertTo-Json
Invoke-RestMethod -Method Put -Uri "http://jsonplaceholder.typicode.com/posts/1" -Body $Json -ContentType 'application/json'## Using REST with PowerShell Objects to GET and POST many items## GET your REST data and store in a PowerShell object:$Users = Invoke-RestMethod -Uri "http://jsonplaceholder.typicode.com/users"##Modify many items in your data:$Users[0].name = "John Smith"
$Users[0].email = "John.Smith@example.com"
$Users[1].name = "Jane Smith"
$Users[1].email = "Jane.Smith@example.com"## POST all of the REST data back:$Json = $Users | ConvertTo-Json
Invoke-RestMethod -Method Post -Uri "http://jsonplaceholder.typicode.com/users" -Body $Json -ContentType 'application/json'## Using REST with PowerShell to Delete items## Identify the item that is to be deleted and delete it:Invoke-RestMethod -Method Delete -Uri "http://jsonplaceholder.typicode.com/posts/1"