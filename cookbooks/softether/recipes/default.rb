%w(
  gcc
).each do |package|
  yum_package "#{package}" do
    action :install
  end
end

include_recipe "softether::softether"
