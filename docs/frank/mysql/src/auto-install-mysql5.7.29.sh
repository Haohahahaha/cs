mkdir mysql-tmp
cd mysql-tmp
wget -P ./ https://cdn.mysql.com/archives/mysql-5.7/mysql-server_5.7.29-1ubuntu18.04_amd64.deb-bundle.tar
tar -xvf mysql-server_5.7.29-1ubuntu18.04_amd64.deb-bundle.tar
sudo dpkg -i libmysqlclient20_5.7.29-1ubuntu18.04_amd64.deb 
sudo dpkg -i libmysqlclient-dev_5.7.29-1ubuntu18.04_amd64.deb
sudo dpkg -i libmysqld-dev_5.7.29-1ubuntu18.04_amd64.deb
sudo dpkg -i mysql-common_5.7.29-1ubuntu18.04_amd64.deb
sudo dpkg -i mysql-community-source_5.7.29-1ubuntu18.04_amd64.deb
sudo dpkg -i mysql-community-client_5.7.29-1ubuntu18.04_amd64.deb
sudo apt-get install libaio1 libtinfo5 libmecab2
sudo dpkg -i mysql-client_5.7.29-1ubuntu18.04_amd64.deb 
sudo dpkg -i mysql-community-server_5.7.29-1ubuntu18.04_amd64.deb
sudo dpkg -i mysql-server_5.7.29-1ubuntu18.04_amd64.deb
service mysql start
mysql -u root -p
