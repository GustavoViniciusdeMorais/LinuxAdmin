#!/bin/bash
# chmod u+x mydockerexec.sh
# bash mydockerexec.sh api_container_name
docker exec -it -u 0 $1 bash
