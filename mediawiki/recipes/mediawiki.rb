execute 'run command' do
  command 'rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm'
  action :run
end

execute 'run command' do
  command 'rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm'
end

#bash 'packages' do
#  user 'root'
#  cwd '/'
#  code <<-EOH
#  rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rp
#  rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
#  EOH
#end


%w(httpd mariadb mariadb-server  mod_php71w php71w-cli php71w-common php71w-gd php71w-mbstring php71w-mcrypt php71w-mysqlnd php71w-xml ImageMagick-perl texlive wget libselinux-python).each do |package|
  package package do 
    action :install
  end
end

#bash 'packages' do
#  user 'root'
#  cwd '/'
#  code <<-EOH
#  rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rp
#  rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
#  EOH
#end


bash 'Install Mediawiki' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
  wget http://releases.wikimedia.org/mediawiki/1.22/mediawiki-1.22.3.tar.gz
  tar -zxf mediawiki-1.22.3.tar.gz
  mkdir /var/www/html/mediawiki
  mv /tmp/mediawiki-1.22.3/* /var/www/html/mediawiki
  chown -R apache:apache /var/www/html/mediawiki
  chmod -R 755 /var/www/html/mediawiki
   EOH
end

#service 'httpd' do
#  action [ :restart, :enable ]
#end

#service 'mariadb' do
#  action [ :restart, :enable ]
#end

service 'httpd' do
  supports :restart => true, :reload => true
  action :enable
end

service 'mariadb' do
  supports :restart => true, :reload => true
  action :enable
end
execute 'run command' do
  command 'setenforce 0'
  action :run
end
