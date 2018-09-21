## Description
phpipamscanagent is a scanning agent for phpipam server to be deployed to remote servers in docker environment.
This is a docker container for the phpIPAM agent, please see https://github.com/phpipam/phpipam-agent for installation on standalone server.

This docker container will run phpIPAM scan agent with update and discover parameters and can be used to setup a scheduled scan of the subnets without installing PHP or any of the php modules on host server.  

## License
phpipam is released under the GPL v3 license, see misc/gpl-3.0.txt.
This docker container is released under the same license.

## Requirements
 - A running phpIPAM server either in Docker container or standalone server. Visit https://github.com/pierrecdn/phpipam.
 - A valid database username and password of the phpIPAM database.
 - You will need to update the config.php file with your own environment for subnet scanning to work.
 - This docker container includes the required PHP & PHP modules for phpIPAM scan agent to work. You can install additional packages by modifying the dockerfile if you wish to.

## Install
 - Update the config.php files with your scanagent key and database parameters.
   Update the scanagent key obtained from phpIPAM server.
   - `$config['key'] = "335bdc3f11b1879e010776f6979c053c";`
    
   Update the database parameters to match your environment
   - `$config['db']['host'] = "DBHostname";`
   - `$config['db']['user'] = "DBUsername";`
   - `$config['db']['pass'] = "DBPassword";`
   - `$config['db']['name'] = "phpipam";`
   - `$config['db']['port'] = 3306;`
    
 -`docker run --rm -v /src/config.php:/ipamscan/config.php najarramsada/phpipamscanagent`
 
 `--rm` will remove the container after it has completed the update and discover of IPs.
 
 To run the this image in bash mode
 - `docker run -it -v /src/config.php:/ipamscan/config.php najarramsada/phpipamscanagent bash`
 
 To run the this image in detached mode
 - `docker run -t -d -v /src/config.php:/ipamscan/config.php najarramsada/phpipamscanagent`

## Scheduled scans
For scheduled scans set up a crontab to run the container every 15 mins.
 - Update the cronjob.sh with the correct location of the config file and setup a crontab on host server.
 - `crontab -e`
 - `*/15 * * * * /src/cronjob.sh`

cronjob.sh should have the docker run command

`#!/bin/bash`
`docker run --rm --network=host -v /src/config.php:/ipamscan/config.php najarramsada/phpipamscanagent`

## Contact
`ramsadanajar@gmail.com`
