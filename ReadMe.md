## Description
phpipamscanagent is a scanning agent for phpipam server to be deployed to remote servers in docker environment.
This is a docker container for the phpIPAM agent, please see https://github.com/phpipam/phpipam-agent for the actual scanning agent.

This docker container will run phpIPAM scan agent with update and discover parameters and can be used to setup a scheduled scan of the subnets.  

## License
phpipam is released under the GPL v3 license, see misc/gpl-3.0.txt.
This docker container is released under the same license.

## Requirements
 - A running phpIPAM server either in Docker container or standalone server. Visit First install the phpIPAM in docker and configure, visit https://github.com/pierrecdn/phpipam.
 - This docker container includes the required PHP modules. You can install additional packages by modifying the dockerfile if    you wish to.
 - You will need to update the config.php file with your own environment for subnet scanning to work.

## Install
 - Update the config.php files with your scanagent key and database parameters.
 - Run `docker run --rm -v /src/config.php:/ipamscan/config.php najarramsada/phpipamscanagent`

## Scheduled scans
For scheduled scans set up a crontab to run the container every 15 mins.
 - Update the cronjob.sh with the correct location of the config file and setup a crontab on host server.
 - `crontab -e`
 - `*/15 * * * * /src/cronjob.sh`

## Contact
`ramsadanajar@gmail.com`
