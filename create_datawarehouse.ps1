$resourceGroupName = "<Resouce GroupName>"
$location = "<Location>"
$databaseName = "<DatabaseName>"
$collationName = "<CollationName>"
$edtion = "<Edition>"
$serverName = "<ServerName>"
$administratorLogin = "<AdministratorLoginID>"
$administratorLoginPassword = "<AdministratorLoginPassword>"
$subscriptionID = "<SubscriptionID>" 
$sampleDatabase = "<SampleDatabase>"

# Azure ログイン
Login-AzureRmAccount

# Subscriptinの選択
Select-AzureRmSubscription -SubscriptionId $subscriptionID

# Resource Groupの作成
New-AzureRmResourceGroup -Name $resourceGroupName -Location $location

$user = $administratorLogin  
$pass = $administratorLoginPassword 

$str = ConvertTo-SecureString $pass -AsPlainText -Force 
$psc = New-Object System.Management.Automation.PsCredential($user, $str) 
Get-Credential -Credential $psc

# SQL serverの作成
$sql = New-AzureRmSqlServer -ResourceGroupName $resourceGroupName -Location $location -ServerName $serverName -SqlAdministratorCredentials (Get-Credential -Credential $psc)

# SQL DWHの作成
New-AzureRmSqlDatabase -DatabaseName $databaseName `
   -CollationName $collationName `
   -Edition $edtion `
   -ResourceGroupName $resourceGroupName `
   -ServerName $sql.ServerName `
   -SampleName $sampleDatabase