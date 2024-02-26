# Execu��o: .\Backup-SqlAgentJobs.ps1 -servidor "" -pastaDestino ""

param([string]$servidor, [string]$pastaDestino)

# Carrega o SQL Server SMO Assemly
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.Smo") | Out-Null

# Valida��o do destino (pasta aonde os arquivos ser�o persistidos
$destinoExistente = Test-Path $pastaDestino
if($pastaDestino.Substring($pastaDestino.Length-1,1) -ne "\")
{
    $pastaDestino += "\"
}

# Lista os arquivos existentes na pasta
#Get-ChildItem $pastaDestino | ForEach-Object {Write-Host $_.FullName}

#Remove os arquivos da pasta para inclus�o dos jobs mais recentes em execu��o no servidor
Get-Childitem $pastaDestino | Foreach-Object {Remove-Item $_.FullName}

if (Test-Path -Path $pastaDestino)
{
	# Cria uma conex�o SMO para o servidor 
	$srv = New-Object "Microsoft.SqlServer.Management.Smo.Server" $servidor

	# Cria��o de um �nico arquivo para todos os Jobs
	#$srv.JobServer.Jobs | foreach {$_.Script() + "GO`r`n"} | out-file ".\$OutputFolder\jobs.sql"

	# Cria��o de um arquivo por Job
        # Remo��o do caracter backslash, normalmente existente em jobs do agente de replica��o, para evitar problemas de caminho de arquivo
	$srv.JobServer.Jobs | foreach-object -process {out-file -FilePath $("$pastaDestino" + $srv.Name.toUpper() + "_" + $(((($_.Name -replace '\\', '') -replace ':', '') -replace '\[', '') -replace ']', '') + ".sql") -inputobject $_.Script() | write-host $("$pastaDestino" + $srv.Name + "_" + $($_.Name -replace '\\', '') + ".sql") }
}
else
{
    Write-Host "Pasta informada para cria��o dos arquivos n�o foi encontrada."
}
