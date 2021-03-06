#
# Cookbook:: nodejs_nginx
# Spec:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'nodejs_nginx::default' do
  context 'When all attributes are default, on Ubuntu 18.04' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'ubuntu', '18.04'

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    # testing for apt-update
    it 'runs apt get update' do
      expect(chef_run).to update_apt_update 'update_sources'
    end


    # Installing
      # Install Nginx
    it 'Should install Nginx' do
      expect(chef_run).to install_package 'nginx'
    end
      # Install Nodejs
    it 'Should include recipe Nodejs' do
      expect(chef_run).to include_recipe 'nodejs'
    end

    # Services
      # start and enable
    it 'Should Enable Nginx' do
      expect(chef_run).to enable_service 'nginx'
    end

    it 'Should Start Nginx' do
      expect(chef_run).to enable_service 'nginx'
    end

    # if we created a new proxy.config file for Nginx
    it 'should create a proxy.conf template in /etc/nginx/sites-available' do
      expect(chef_run).to create_template('/etc/nginx/sites-available/proxy.conf').with_variables(proxy_port: 3000)
    end

    it 'Should create a symlink from proxy.conf to /etc/nginx/sites-enabled' do
      expect(chef_run).to create_link("/etc/nginx/sites-enabled/proxy.conf").with_link_type(:symbolic)
    end

    it 'should delete link from proxy.conf.erb to /etc/nginx/sites-enabled' do
      expect(chef_run).to delete_link "/etc/nginx/sites-enabled/default"
    end

    it 'should install pm2 via npm' do
      expect(chef_run).to install_nodejs_npm('pm2')
    end

    it 'should install react via npm' do
      expect(chef_run).to install_nodejs_npm('react')
    end

  end
end
