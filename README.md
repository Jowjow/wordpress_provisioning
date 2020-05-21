# Wordpress provisioning
A fast and automatic way to provision a containerized LEMP stack and a Jenkins instance on a remote server using Ansible and Docker.

## Architecture:

A containerized architecture was choosen for both the CICD node and the Wordpress node because of the straightforwardness in dealing with the dependencies for every service on the stack(like mysql, nginx and php), this way we only have to deal with the docker and docker-compose dependencies. Also we have an isolated environment for each different service, this way we are less likely to affect a service while we modify the other. 

## Dependencies:

The sole dependency needed on the deployer's local machine is Ansible. Of course, an internet connection and actual credentials to connect with the host machine are also needed. One could provide the DNS(or IP address) of another target host on the hosts.yml. The present credencials have been redacted for security.

## Instructions:

To deploy the Wordpress stack completely, first edit the `hosts.yml` to reflect your actual targeted host, afterwards it comes down to one simples command:

  `ansible-playbook provisioning/site.yml -i provisioning/hosts.yml`

To deploy the Jenkins instance follow the same process on `hosts.yml` as above and then run:

  `ansible-playbook provisioning/cicd.yml -i provisioning/hosts.yml`
  
## Ansible Roles:

An Ansible approach based on roles was designed because it isolates different stages of the deployment process, and makes possible additions to this process fairly easier in the future, also it increasing code readability and is a nice organized way to deal with your playbooks. 

### Project Roles:
  - setup: Installs all needed dependencies on host, transfer needed files, makes some network configurations and actually spins up a HTTP based version of the Wordpress website.
  
  - update: Changes files, and recreate needed containers with the right parameters to set up HTTPS on the Wordpress website, also sets up the cron jobs outlined in the challenge definition.
  
  - jenkins: Installs dependencies, manage files(like the pipeline.sh script, which had to be slightly modified because of the contenairized architecture, although the result remains the same) and spins up a jenkins server.
  
  PS: The `site.yml` playbook runs both the setup and update roles' tasks. 
  
Also, a Jenkins job(on the known Jenkins instance) is ran everytime a push is made to this repository's master branch. 
  
For more information take a dive into the code or reach out for any questions. 
  
