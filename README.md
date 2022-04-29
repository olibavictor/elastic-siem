# Instalação e configuração de cluster Elastic SIEM 8.1

- Instalação Elastic Stack (elasticsearch/kibana/logstash)
- Configuração do cluster elasticsearch
  - Alteração no arquivo de configuração em todos os nós:
      -  cluster.name
      -  node.name
      -  path.data (default)
      -  path.logs (default)
      -  network.host
      -  http.port
      -  discovery.seed_hosts
      -  cluster.initial_master_nodes
   - Gerar certificados para implementação
      -  Gerar nova CA
      -  Gerar certiicado para comunicação entre nós do cluster
      -  Gerar certificado http para API elasticsearch e .pem para kibana conseguir fazer requisições https para elastic
    - Configurar novos certificados no arquivos de configuração
    - Caso os certificados configuados tenham senha, é preciso configurar o keystores do elasticsearch para que ele consiga acessar os certificados
- Configuração do cluster kibana
  - Alteração do arquivos de configuração em todas as intancias:
      - server.port (default)
      - server.host
      - server.publicBaseUrl
      - server.name
      - elasticsearch.hosts
      - elasticsearch.username
      - elasticsearch.password
      - elasticsearch.ssl.certificateAuthorities
      - xpack.encryptedSavedObjects.encryptionKey
      - xpack.reporting.encryptionKey
      - xpack.security.encryptionKey
   - Colocar HAProxy na frente das intancias do kibana para balancear a carga
  
# Configuração de kesytore 

<#./elasticsearch-keystore add xpack.security.http.ssl.keystore.secure_password
./elasticsearch-keystore add xpack.security.transport.ssl.keystore.secure_password
./elasticsearch-keystore add xpack.security.transport.ssl.truststore.secure_password#>
