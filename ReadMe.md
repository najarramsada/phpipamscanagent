## Description
phpipamscanagent is a scanning agent for phpipam server to be deployed to remote servers in docker environment.
This is a docker container for the phpIPAM agent, please see https://github.com/phpipam/phpipam-agent for the actual scanning agent.

## License
phpipam is released under the GPL v3 license, see misc/gpl-3.0.txt.
This docker container is released under the same license.

## Requirements
 - This docker container includes the required PHP modules. You can install additional packages by modifying the dockerfile.

## Install
 - Update the config.php files with your scanagent key and database parameters.
 - Run `docker-compose up -d`

## Scheduled scans
For scheduled scans you have to run script from cron. Add something like following to your cron to scan
each 15 minutes:

Once the docker container is running, enter the docker bash and update the crontab of the container.
 `docker exec -it <Container ID> bash
 `crontab -e`
 `*/15 * * * * php /where/your/agent/index.php update`

## Contact
`ramsadanajar@gmail.com`