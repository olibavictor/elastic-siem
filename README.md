## Elastic SIEM Configuration 8.1/8.2

### Configuração de disco Elasticsearch (Particionamento e LVM config)

>root  "/" 100GB 
>
>data  "/var/lib/elasticsearch" 800GB
>
>log   "/var/log/elasticsearch" 100GB


### Configuração de disco Kibana (Particionamento e LVM config)

>root  "/" 100GB
>
>data  "/var/lib/kibana" 100GB
>
>log   "/var/log/kibana" 100GB
    
### Configuração do cluster Elasticsearch

***Alterações no arquivo de configuração em todos os nós***

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

### Configuração do cluster Kibana

***Alterações no arquivos de configuração em todas as instâncias***

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

>***Colocar HAProxy na frente das intancias do kibana para balancear a carga***
  
### Gerar certificados Elasticsearch
>***Use /bin/elasticsearch-certutil para gerar os certificados***

>Gerar nova CA

``
./usr/share/elasticsearch/bin/elasticsearch-certutil ca
``

>Gerar certiicado para comunicação entre nós do cluster 

``
./usr/share/elasticsearch/bin/elasticsearch-certutil cert --ca elastic-CA.p12
``

>Gerar certificado http para API elasticsearch e ca.pem para que o kibana consiga se comunicar com o cluster via https

``
./usr/share/elasticsearch/bin/elasticsearch-certutil http
``

>Configurar novos certificados no arquivos de configuração elasticsearch.yml
>
>Caso os certificados configuados tenham senha, é preciso configurar o keystore do elasticsearch para que ele consiga acessar os certificados

### Gerar certificados Kibana
>***Use /bin/elasticsearch-certutil para gerar os certificados***

>Gerar certificado para acesso da aplicação via browser HTTPS

``
./usr/share/elasticsearch/bin/elasticsearch-certutil ca --pem 
``

>Configurar novos certificados no arquivos de configuração kibana.yml
>
>Caso os certificados configuados tenham senha, é preciso configurar o keystore do elasticsearch para que ele consiga acessar os certificados

### Configuração de keystore Elasticsearch

``
./elasticsearch-keystore add xpack.security.http.ssl.keystore.secure_password
``
>
``
./elasticsearch-keystore add xpack.security.transport.ssl.keystore.secure_password
``
>
``
./elasticsearch-keystore add xpack.security.transport.ssl.truststore.secure_password
``

### Configuração de keystore Kibana
``
./kibana-keystore add elasticsearch.username
``
>
``
./kibana-keystore add elasticsearch.password
``

### Validar informações e saude dos nós do cluster Elasticsearch
``
curl -k -u elastic https://localhost:9200/_cat/nodes?v
``

### Migrar kibana para a porta 443

>Primeiro precisamos alterar a porta no arquivo de configuração "kibana.yml"
>
>Depois disso precisamos dar permissão de todos os executaveis do kibana para as portas privilegiadas "< 1024"

``
sudo setcap cap_net_bind_service=+epi /usr/share/kibana/bin/kibana
``
>
``
sudo setcap cap_net_bind_service=+epi /usr/share/kibana/bin/kibana-plugin
``
>
``
sudo setcap cap_net_bind_service=+epi /usr/share/kibana/bin/kibana-keystore
``
>
``
sudo setcap cap_net_bind_service=+epi /usr/share/kibana/node/bin/node
``
