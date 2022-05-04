## Configuração de discos

### Configuração de disco elasticsearch (Particionamento e LVM config)

>root  "/" 100GB 
>
>data  "/var/lib/elasticsearch" 800GB
>
>log   "/var/log/elasticsearch" 100GB


### Configuração de disco kibana (Particionamento e LVM config)

>root  "/" 100GB
>
>data  "/var/lib/kibana" 100GB
>
>log   "/var/log/kibana" 100GB
    
### Configuração do cluster elasticsearch

**Alterações no arquivo de configuração em todos os nós**

>cluster.name
>
>node.name
>
>path.data (default)
>
>path.logs (default)
>
>network.host
>
>http.port
>
>discovery.seed_hosts
>
>cluster.initial_master_nodes

### Configuração do cluster kibana

**Alterações no arquivos de configuração em todas as intancias:**

>server.port (default)
>
>server.host
>
>server.publicBaseUrl
>
>server.name
>
>elasticsearch.hosts
>
>elasticsearch.username
>
>elasticsearch.password
>
>elasticsearch.ssl.certificateAuthorities
>
>xpack.encryptedSavedObjects.encryptionKey
>
>xpack.reporting.encryptionKey
>
>xpack.security.encryptionKey

>**Colocar HAProxy na frente das intancias do kibana para balancear a carga**
  
# Configuração de kesytore Elasticsearch

- ./elasticsearch-keystore add xpack.security.http.ssl.keystore.secure_password
- ./elasticsearch-keystore add xpack.security.transport.ssl.keystore.secure_password
- ./elasticsearch-keystore add xpack.security.transport.ssl.truststore.secure_password

# Configuração de keystore Kibana

- ./kibana-keystore add elasticsearch.username
- ./kibana-keystore add elasticsearch.password

# Gerar certificados Elasticsearch

-Gerar certificados para implementação
      -  Gerar nova CA
      -  Gerar certiicado para comunicação entre nós do cluster
      -  Gerar certificado http para API elasticsearch e .pem para kibana conseguir fazer requisições https para elastic
    - Configurar novos certificados no arquivos de configuração
    - Caso os certificados configuados tenham senha, é preciso configurar o keystores do elasticsearch para que ele consiga acessar os certificados

- /usr/share/elasticsearch/bin/elasticsearch-certutil ca
- /usr/share/elasticsearch/bin/elasticsearch-certutil cert --ca elastic-CA.p12
- /usr/share/elasticsearch/bin/elasticsearch-certutil http (mover "ca.pem" para o kibana reconhecer a comunicação com todo os nós elastic)

# Gerar certificados Kibana

- ./elasticsearch-certutil ca --pem (Configurar crt e key no kibana.yml)

# Testar funcionamento do cluster elasticsearch

- curl -k -u elastic https://localhost:9200/_cat/nodes?v

