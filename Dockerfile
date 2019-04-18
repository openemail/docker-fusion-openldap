FROM tiredofit/openldap-fusiondirectory
LABEL maintainer="Chinthaka Deshapriya (chinthaka@cybergate.lk)"

## Set Environment Varialbes
ENV ZABBIX_HOSTNAME=openldap-fusion-openemail \ 
    DEBUG_MODE=FALSE \
    ENABLE_CRON=TRUE \
    ENABLE_SMTP=TRUE \
    SMTP_HOST=postfix-openemail \
    SMTP_USER=appmaster \
    SMTP_PASS=openemail \
    TERM=xterm 
    
    
    
