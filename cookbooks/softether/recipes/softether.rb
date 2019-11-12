
`ls /usr/local/vpnserver/vpnserver`
if not $? == 0

  remote_file "/tmp/softether-vpnserver-v4.25-9656-rtm-2018.01.15-linux-x64-64bit.tar.gz" do
    source 'http://jp.softether-download.com/files/softether/v4.25-9656-rtm-2018.01.15-tree/Linux/SoftEther_VPN_Server/64bit_-_Intel_x64_or_AMD64/softether-vpnserver-v4.25-9656-rtm-2018.01.15-linux-x64-64bit.tar.gz'
  end

  execute 'unpack' do
    command 'tar -zxvf softether-vpnserver-v4.25-9656-rtm-2018.01.15-linux-x64-64bit.tar.gz'
    cwd "/tmp"
  end

  execute 'build' do
    command 'yes 1 | make'
    cwd "/tmp/vpnserver"
  end

  execute 'chmod' do
    command <<-EOF
      mv /tmp/vpnserver /usr/local/
      chmod 600 /usr/local/vpnserver/*
      chmod 700 /usr/local/vpnserver/vpncmd
      chmod 700 /usr/local/vpnserver/vpnserver
      EOF
  end

else
  p ' * vpnserver-build is skipped due to not_if '
end

cookbook_file "/etc/init.d/vpnserver" do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

execute 'chkconfig-add' do
    command '/sbin/chkconfig --add vpnserver'
    not_if 'chkconfig --list vpnserver'
end

service "vpnserver" do
  action [ :enable, :start ]
end

`/usr/local/vpnserver/vpncmd /server #{node['softether']['privateip']} /adminhub:#{node['softether']['hubname']} /cmd SecureNatStatusGet | grep Yes`
if not $? == 0

  template '/tmp/softether-radius.txt' do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end

  execute 'softether-config' do
    command "/usr/local/vpnserver/vpncmd #{node['softether']['privateip']} /SERVER /IN:softether-radius.txt"
    cwd "/tmp"
  end
else
  p ' * softether-config is skipped due to not_if '
end
