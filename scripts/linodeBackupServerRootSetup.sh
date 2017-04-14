# For remote backup server

# Run as root to perform initial setup and user account creation

# Runs interactively (asks for a password)

apt-get -o Acquire::ForceIPv4=true update
apt-get -y install emacs-nox mercurial


echo ""
echo ""
echo "Setting up new user account jcr13 without a password..."
echo ""
echo ""

useradd -m -s /bin/bash jcr13


su jcr13<<EOSU

cd /home/jcr13

mkdir .ssh

chmod 744 .ssh

cd .ssh

echo "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAsiD85AwaNxcUzNzHPapVaGVIQCTUfdKT2tyd26MWqEds2UHLZund+S930BWz7guu3/mzuTomJnPxZPSyb+62ZiuAR0YaGZwYwMrFkrbPsXf6//MZDBvdMMcqPyqLj3Iny2ZZ9LTnSIs0hqQ3SksvP/qqHthS1YQWMwZlRxs6MmZdEuy4qZZgpnexf6uaWTEcxEO2Nij8LdEN8+jJZLHVkXSSD9c/ssTmdXss3/sVSZHYR+28HeqUahRsO0Rz6mR3FwB+ZslZlWiMFTzjkH5IA/XOiNK5Ezf1+EsQOn2OVfaCMlfJQ6YGp1kgFI01j2ZWHnqHaacvVc+C+9fAmIscZw==" > authorized_keys

chmod 644 authorized_keys


cd /home/jcr13

mkdir backups

mkdir checkout
cd checkout
hg clone http://hg.code.sf.net/p/hcsoftware/OneLife


echo ""
echo "Setting up remote cron job to run backup at hour 10 UTC."
echo ""

cd /home/jcr13

echo "0 10 * * * /home/jcr13/checkout/OneLife/scripts/backupCron.sh" > crontabSource

crontab crontabSource



exit
EOSU


echo ""
echo "Done with remote setup."
echo ""


