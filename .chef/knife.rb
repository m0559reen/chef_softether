local_mode true
knife[:ssh_attribute] = "knife_zero.host"

knife[:use_sudo] = true
knife[:identity_file] = "/chef/key.pem"
knife[:ssh_user] = "ec2-user"
knife[:ssh_gateway] = "xxx.xxx.xxx.xxx"

knife[:automatic_attribute_whitelist] = [
  "fqdn/",
  "os/",
  "os_version/",
  "hostname/",
  "ipaddress/",
  "roles/",
  "recipes/",
  "ipaddress/",
  "platform/",
  "platform_version/",
  "cloud/",
  "cloud_v2/",
  "chef_packages/",
]
