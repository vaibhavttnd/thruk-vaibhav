bash 'thruk install' do
  code <<-EOF
 
sudo apt-get update
sudo wget http://download.thruk.org/pkg/v2.08/ubuntu14.04/amd64/libthruk_2.08-1_ubuntu14.04_amd64.deb
sudo wget http://download.thruk.org/pkg/v2.08/ubuntu14.04/amd64/thruk-base_2.08_ubuntu14.04_amd64.deb
sudo wget http://download.thruk.org/pkg/v2.08/ubuntu14.04/amd64/thruk-plugin-reporting_2.08_ubuntu14.04_amd64.deb
sudo wget http://download.thruk.org/pkg/v2.08/ubuntu14.04/amd64/thruk_2.08_ubuntu14.04_amd64.deb

sudo dpkg -i libthruk_2.08-1_ubuntu14.04_amd64.deb
sudo dpkg -i thruk-base_2.08_ubuntu14.04_amd64.deb
sudo dpkg -i thruk-plugin-reporting_2.08_ubuntu14.04_amd64.deb
sudo dpkg -i thruk_2.08_ubuntu14.04_amd64.deb


  EOF
end



#install live status
package 'check-mk-livestatus' do
  action :install
end


#htpasswd for thruk
template '/etc/apache2/conf-enabled/thruk.conf' do
  source "thruk.conf.erb"
  owner "root"
  group "root"
  mode "0644"
end


# thruk_local.conf
template '/etc/thruk/thruk_local.conf' do
  source "thruk_main.conf.erb"
  owner "www-data"
  group "www-data"
  mode "0644"
end

#cgi.cfg file
template '/etc/thruk/cgi.cfg' do
  source "cgi.cfg.erb"
  owner "root"
  group "root"
  mode "0644"
end

#nagios.cfg file
template '/etc/nagios3/nagios.cfg' do
  source "nagios.cfg.erb"
  owner "root"
  group "root"
  mode "0644"
end


bash 'permissions' do
  code <<-EOF
    
sudo /etc/init.d/nagios3 stop
sudo dpkg-statoverride --update --add nagios www-data 2710 /var/lib/nagios3/rw
sudo dpkg-statoverride --update --add nagios nagios 751 /var/lib/nagios3
sudo /etc/init.d/nagios3 start

  EOF
end
