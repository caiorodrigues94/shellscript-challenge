#Scritp em Shell script para Backup do Web Server


#Criando variáveis de ambiente
distro=$(cut -d"=" -f2 /etc/*-release | sed -n '1p')
data=$(/bin/date +%d-%m-%y)
backup_webserver=~/backup-web-server
apache2_files=/etc/apache2
apache2_log=/var/log/apache2
httpd_files=/etc/httpd
httpd_log=/var/log/httpd
www_files=/var/www

#Criando diretório para arquivos de backup
mkdir $backup_webserver
#Criando backup de acordo com a distribuição
if [ "$distro" = Ubuntu ]; then
  tar -zcf backup-apache2-${data}.tar.gz $apache2_files && mv backup-apache2-${data}.tar.gz $backup_webserver
  tar -zcf backup-wwww-${data}.tar.gz $www_files && mv backup-wwww-${data}.tar.gz $backup_webserver
  tar -zcf backup-log-${data}.tar.gz $apache2_log && mv backup-log-${data}.tar.gz $backup_webserver
else
  tar -zcf backup-httpd-${data}.tar.gz $httpd_files && mv backup-httpd-${data}.tar.gz $backup_webserver
  tar -zcf backup-wwww-${data}.tar.gz $www_files && mv backup-wwww-${data}.tar.gz $backup_webserver
  tar -zcf backup-log-${data}.tar.gz $httpd_log && mv backup-log-${data}.tar.gz $backup_webserver
fi


#Verificando se o backup foi realizado
if [ "$?" = 1 ]; then
  echo "Realizado com Sucesso" >> /var/log/script-backup.log
else
  echo "Sem Sucesso" >> /var/log/script-backup.log
fi
