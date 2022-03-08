#Script updates the package information
sudo apt update
#Script ensures that the HTTP Apache server is installed
apt-get install apache2
#Script ensures that HTTP Apache server is running
servstat=$(sudo systemctl status apache2)
#Script ensures that HTTP Apache service is enabled
if [[ $servstat = *"active (running)"* ]];
then
  echo "process is running"
else
  sudo systemctl start apache2.service
fi
cd /var/log/apache2
ls
#Archiving logs to S3
timestamp=$(date '+%d%m%Y-%H%M%S')
myname=suchismita
tarfilename=$myname-httpd-logs-$timestamp
tar -cf $tarfilename.tar access.log error.log
cp $tarfilename.tar /tmp
sudo apt install awscli
# AWS configure should be completed
echo "aws config has been done"
s3_bucket=upgrad_$myname
aws s3 mb $s3_bucket
aws s3 cp /tmp/$tarfilename.tar s3://${s3_bucket}/${myname}-httpd-logs-${timestamp}.tar
# task 3
sudo systemctl enable cron
mkdir -p /etc/cron.d/automation
sudo crontab -e
read 1
touch * * * * * root /root/Automation_Project/automation.sh

mkdir -p /var/www/html/inventory.html




