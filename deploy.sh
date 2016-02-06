#########################################################################
# File Name: deploy.sh
# Author: Gu Shenlong
# mail: blackhero98@gmail.com
# Created Time: Sat Feb  6 10:09:21 2016
#########################################################################
#!/bin/bash
#scp
cd ~/Desktop
scp -i cloudtweetmap.pem  ~/stockhunter/web_service.py  ec2-user@52.91.227.244:/home/ec2-user
scp -i cloudtweetmap.pem  ~/stockhunter/database_util.py ec2-user@52.91.227.244:/home/ec2-user
scp -i cloudtweetmap.pem  ~/stockhunter/bing_search.py ec2-user@52.91.227.244:/home/ec2-user
scp -i cloudtweetmap.pem  ~/stockhunter/alchemy_util.py ec2-user@52.91.227.244:/home/ec2-user
scp -i cloudtweetmap.pem  ~/stockhunter/yahoo_util.py ec2-user@52.91.227.244:/home/ec2-user
scp -i cloudtweetmap.pem  ~/stockhunter/server_deploy.sh ec2-user@52.91.227.244:/home/ec2-user
