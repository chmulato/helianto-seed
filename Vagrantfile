VAGRANTFILE_API_VERSION = "2"  
Vagrant.require_version ">= 1.6.0"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.ssh.insert_key = false
  
  config.vm.define"database" do |db|
    db.vm.provider "docker" do |d|
      d.image="mysql:5.6.26"
      d.env = {
        :MYSQL_ROOT_PASSWORD => "root",
        :MYSQL_DATABASE     => "phase23",
        :MYSQL_USER         => "helianto",
        :MYSQL_PASSWORD     => "helianto"
      }
      d.ports =["3306:3306"]
      d.volumes = ["/usr/local/mysql/data/:/var/lib/mysql"]
      d.remains_running = "true"
      d.vagrant_vagrantfile = "./Vagrantfile.proxy"
    end
  end
  
  config.vm.define "tomcat" do |v|
    v.vm.provider "docker" do |d|
      d.build_dir = "./dockerfiles/iservport-tomcat-testit"
      d.ports = [ "8080:8080" ]
      d.volumes = ["/var/lib/tomcat7/webapps/"]
      d.vagrant_vagrantfile = "./Vagrantfile.proxy"
    end
  end
  
end
