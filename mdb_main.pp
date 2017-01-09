 
class  project::mdb_main 
  
   {

  
   
# ----------------------------------------------------------------------------
# mysql server setup
# ----------------------------------------------------------------------------

#allow mysql to listen every ip address  
   $override_options = {
 
  'mysqldump' => {
    'password'=> [hiera('bundle::project::mdb_main::backup_pass')],
  },
   'mysqld' => {
    'bind-address' => [''],
    'datadir' => '/local/mysql',
  }
}

#initiating mysql server
  class { '::mysql::server':
  root_password           => hiera('project::mdb_main::root_pass'),
  remove_default_accounts => true,
  override_options        => $override_options
}

  # create general mysql user for backups, phpmyadmin and other
mysql::db { 'mysql':
  user     => 'master',
  password => hiera('project::mdb_main::master_pass'),
  host     => '%',
  grant    => ['SELECT', 'INSERT', 'UPDATE', 'DELETE'],
}

mysql::db { 'mysqltest':
  user     => 'master',
  password => hiera('project::mdb_main::master_pass'),
  host     => '%',
  grant    => ['SELECT', 'INSERT', 'UPDATE', 'DELETE'],
}


        

# ----------------------------------------------------------------------------
# Add any additional settings *above* this comment block.
# ----------------------------------------------------------------------------

   
}
