# use Net::FTP;
# use Net::SCP;
# use Net::SCP::Expect;
# sub scp_backup{
        # $n = scalar(@_);
        # if ($n == 7)
        # {           my $dest="proddd.txt";
                    # my $testfile = "/usr/local/apache-tomcat/logs/ server.log.2016-02-03";

                    # my $scpe = Net::SCP::Expect->new(
                           # host => $ip,
                           # user => $username,
                           # password => $password,
                           # auto_yes => 1,
                           # verbose  => 1,
                           # debug    => 1,
                           # timeout_auto => 2,
                        # );
                        # die "can't scp: $!\n" unless $scpe->scp($testfile, $dest);
        # }
        # else
        # {
                # print "\nNot enough args\n\n";
        # }
        # print "\nTotal items passed:$n\n";
# }
# $name = "as15627";
# $tfr_type = "scp";
# $ip = "54.251.186.145";
# $username = 'as15627';
# $password = ' ';
# &scp_backup($name, $tfr_type, $ip, $username, $password);



use Net::OpenSSH;
my $ssh = Net::OpenSSH->new("54.251.186.145", user => "as15627", password => " ");
$ssh->scp_put($local_path, $remote_path)
    or die "scp failed: " . $ssh->error;