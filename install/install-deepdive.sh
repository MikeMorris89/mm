#!/bin/bash	

echo 'alias deepdive="bash <(curl -fsSL git.io/getdeepdive)"' >> /home/$user/.aliasrc
source /home/$user/.aliasrc
deepdive

