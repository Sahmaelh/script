#!/bin/sh

# docker export container named

docker export so-suricata -o > /home/so-suricata.tar
docker export so-filebeat -o > /home/so-filebeat.tar
docker export so-steno -o > /home/so-steno.tar
docker export so-zeek -o > /home/so-zeek.tar
docker export so-elasticsearch -o > /home/so-elasticsearch.tar
docker export so-logstash -o > /home/so-logstash.tar
docker export so-influxdb -o > /home/so-influxdb.tar
docker export so-telegraf -o > /home/so-telegraf.tar
docker export so-nginx -o > /home/so-nginx.tar
docker export so-fleet -o > /home/so-fleet.tar
docker export so-soc -o > /home/so-soc.tar
docker export so-kibana -o > /home/so-kibana.tar
docker export so-playbook -o > /home/so-playbook.tar
docker export so-thehive -o > /home/so-thehive.tar
docker export so-cortex -o > /home/so-cortex.tar
docker export so-thehive-es -o > /home/so-thehive-es.tar
docker export so-soctopus -o > /home/so-soctopus.tar
docker export so-elastalert -o > /home/so-elastalert.tar
docker export so-curator -o > /home/so-curator.tar
docker export so-strelka-filestream -o > /home/so-strelka-filestream.tar
docker export so-strelka-manager -o > /home/so-strelka-manager.tar
docker export so-strelka-backend -o > /home/so-strelka-backend.tar
docker export so-strelka-frontend -o > /home/so-strelka-frontend.tar
docker export so-strelka-gatekeeper -o > /home/so-strelka-gatekeeper.tar
docker export so-strelka-coordinator -o > /home/so-strelka-coordinator.tar
docker export so-redis -o > /home/so-redis.tar
docker export so-wazuh -o > /home/so-wazuh.tar
docker export so-mysql -o > /home/so-mysql.tar
docker export so-idstools -o > /home/so-idstools.tar
docker export so-grafana -o > /home/so-grafana.tar
docker export so-aptcacherng -o > /home/so-aptcacherng.tar
docker export so-kratos -o > /home/so-kratos.tar
docker export so-sensoroni -o > /home/so-sensoroni.tar
docker export so-dockerregistry -o > /home/so-dockerregistry.tar



docker volumes ls > /home/volumes.log
docker container ps > /home/container_list.log