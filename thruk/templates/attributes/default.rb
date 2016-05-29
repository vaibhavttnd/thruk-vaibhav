

default['thruk']['htpasswd']="/etc/nagios3/htpasswd.users"


default['thruk']['peer']="/var/lib/nagios3/rw/live"

default['thruk']['resource_file']="/etc/nagios3/resource.cfg"

default['thruk']['core_conf']="/etc/nagios3/nagios.cfg"

default['thruk']['obj_check_cmd']="/usr/bin/nagios3 -v /etc/nagios3/nagios.cfg"

default['thruk']['obj_reload_cmd']="/etc/init.d/nagios3 reload"


default['thruk']['user']="nagiosadmin"
