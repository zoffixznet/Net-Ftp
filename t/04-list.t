
use v6;
use Test;

use Net::Ftp;

plan 4;

##mirrors.sohu.com is a anonymous ftp service 
my $ftp = Net::Ftp.new(:host('013.3vftp.com'),:user('ftptest138'), :pass('123456'), :passive);

$ftp.login();
isnt($ftp.ls(), (), "list file success");
is($ftp.ls('/fedora'), (), "list file success");
isnt($ftp.ls('./root/'), (), "list file success");
is($ftp.ls('iuoda/'), (), "list file success");
$ftp.quit();
			
