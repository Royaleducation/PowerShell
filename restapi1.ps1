
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add('http://+:8000/') 
$listener.Start()
'Listening ...'
 

while ($true) {
    $context = $listener.GetContext() 
 
    $request = $context.Request
 
    
    $response = $context.Response
   
    
    if ($request.Url -match '/end$') { 
        break 
    } else {
 
        
        $requestvars = ([String]$request.Url).split("/");        
 
        # If a request is sent to http:// :8000/wmi
        if ($requestvars[3] -eq "wmi") {
           
            # Get the class name and server name from the URL and run get-WMIObject
            $result = get-WMIObject $requestvars[4] -computer $requestvars[5];
 
            
            $message = $result | ConvertTo-Json; 
            $response.ContentType = 'application/json';
 
       } else {
 
            
            $message = "This is not the page you're looking for.";
            $response.ContentType = 'text/html' ;
       }
 
       
       [byte[]]$buffer = [System.Text.Encoding]::UTF8.GetBytes($message)
       
       # Set length of response
       $response.ContentLength64 = $buffer.length
       
       
       $output = $response.OutputStream
       $output.Write($buffer, 0, $buffer.length)
       $output.Close()
   }    
}
 

$listener.Stop()
 