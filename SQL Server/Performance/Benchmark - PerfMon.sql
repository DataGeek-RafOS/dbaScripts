Counters para cria��o do benchmark

Memory
     Available Mbytes - Quantidade de mem�ria f�sica, em MB, imediatamente dispon�vel para um processo ou uso do sistema.
     Page Faults/sec - Quantidade de falhas de p�ginas n�o encontradas em mem�ria. Hard faults requerem acesso ao disco.
     Pages/sec - Taxa na qual p�ginas s�o lidas ou escritas para o disco para resolver hard faults.

PhysicalDisk
     % Disk Time - Porcentagem de tempo gasto que o disco selecionado ficou ocupado servindo requisi��es de IO.
     Avg. Disk sec/Read - Tempo m�dio, em segundos, de uma lida de dados no disco.
     Avg. Disk sec/Write - Tempo m�dio, em segundos, de uma escrita de dados no disco.
     Current Disk Queue Length - N�mero de requisi��es realizadas sobre um disco no momento em que foi coletado.
     Disk Bytes/sec - Taxa de bytes que s�o transferidos para ou do disco durante opera��es de IO.
     Disk Transfers/sec - Taxa de opera��es de leitura e escrita no disco.

Processor
     % Privileged Time - Porcentagem de tempo gasto em threads de processos executando c�digo em modo privilegiado.
     % Processor Time - Porcentagem de atividade do processador. (>80% = problem)

SQLServer:Access Methods
     FreeSpace Scans/sec - N�m. de scans por seg. iniciados para pesquisar por espa�o livre dentro das p�ginas j� alocadas para modificar fragmentos do registro.
     Full Scans/sec - N�mero de full scans irrestritos. Podem ser por tabela base ou full index scans.

SQLServer:Buffer Manager
     Buffer cache hit radio - Porcentagem de p�ginas encontradas no Buffer Pool que n�o precisaram ser lidos do disco. <97% = potencial memory pressure.
     Checkpoint pages/sec - N�mero de p�ginas que foram liberadas pelo checkpoint ou opera��es que requerem que p�g. sujas sejam liberadas.
     Lazy writes/sec - N�mero de buffers escritos pelo gerenciador do Lazy Writer para o disco. Causado por grandes data cache flushes ou memory pressure. 
     Page life expectancy - Segundos que uma p�gina ficar� no buffer sem refer�ncia (<300 = problem)

SQLServer: General Statistics
     User Connections - N�mero de usu�rios conectados ao sistema.
     
SQLServer:Latches
     Total Latch Wait Time(ms) - Total de tempo de espera, em ms, para requisi��es de trava no �ltimo segundo.

SQLServer:Locks
     Lock Timeouts/sec - N�mero de requisi��es de lock que tiveram time out. Inclui NOWAIT locks.
     Lock Wait Time(ms) - Total de espera, em ms, por locks no �ltimo segundo.
     Number of Deadlocks/sec - N�mero de requisi��es de locks que resultaram em timeout.

SQLServer:Memory Manager
     Memory Grants Pending - N�mero atual de processos esperando por libera��o de espa�o de trabalho em mem�ria.
     Target Server Memory(KB) - Tamanho ideal de mem�ria que o servidor � capaz de consumir.
     Total Server Memory(KB) - Total de mem�ria din�mica que o servidor est� atualmente consumindo.

SQLServer:Plan Cache
     Cache Hit Ratio:SQL Plans - <70% indica baixo reuso de planos.

SQLServer:SQL Statistics
     Batch Requests/sec - N�mero de requisi��es batch recebidas pelo servidor.
     SQL Compilations/sec - (Comparar com Batch Requests/sec)
     SQL Re-Compilations/sec - (Comparar com Batch Requests/sec)

System
     Context Switches/sec - (limite: >5000 x processor) Causas potenciais podem incluir outras aplica��es no servidor ou outras instance.
     Processor Queue Length - (limite: >5 x processor) Causas potenciais podem incluir outras aplica��es no servidor, compila��es ou recompila��es.
     
