param (  
          
        #[Parameter(Mandatory=$true)]
        #[ValidateNotNull()]
       # [String] $ServerNameCSVFilePath   
        [String] $ServerNameCSVFilePath ="D:\Projects\Learner Dotnet\ServerNames.csv"             
)

# Scan File name
$ScanFileName = "Scan.vbe"; 

# Path for the PowerUserPermissionFix.csv
try
{
   $data = Import-csv $ServerNameCSVFilePath 
} 
catch
{
  Write-Host "Error occurred while opening the CSV file" -ForegroundColor Red
  Write-Host  $_.Exception.Message  -ForegroundColor Red    
}


foreach($d in $data) 
{ 
    
    $serverNameFromFile = $d.ServerName


    $C_DrivePath0 ="\\"+$serverNameFromFile+"\C$\Program Files (x86)\UBS AG\Wintel Server Inventory";
    $C_DrivePath1 ="\\"+$serverNameFromFile+"\C$\Program Files (x86)";
    $C_DrivePath2 ="\\"+$serverNameFromFile+"\C$\Program Files";
   
 
  try
  {  
    $FileWithFolderPath = "";
    if(Test-Path -LiteralPath $C_DrivePath0)
    {
        $FileWithFolderPath = Get-ChildItem $C_DrivePath0  -include $ScanFileName -recurse | where-object {$_.name -like $ScanFileName} |select -First 1
    }
    if(!$FileWithFolderPath)
    {
        $FileWithFolderPath = Get-ChildItem $C_DrivePath1  -include $ScanFileName -recurse | where-object {$_.name -like $ScanFileName} |select -First 1
        if(!$FileWithFolderPath)
        {
            $FileWithFolderPath = Get-ChildItem $C_DrivePath2  -include $ScanFileName -recurse | where-object {$_.name -like $ScanFileName} |select -First 1
        }
    }
    if($FileWithFolderPath)
    {
        $FilePath = $FileWithFolderPath.FullName;

        #Add Code to rxecute VBE File 

        #Log to file Code 
        
    }
    else
    {
        # File not found 
        Write-Host "File Not Found"  -ForegroundColor Red 
    }
  }		
   catch
   {
     #Log Exception
      Write-Host $_.Exception.Message  -ForegroundColor Red 
   }
   

} 
Write-Host "Script is complete." -ForegroundColor Yellow
return;