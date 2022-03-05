sudo apt update
apt-get install apache2
sudo systemctl status apache2
cd /var/log/apache2
ls
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


