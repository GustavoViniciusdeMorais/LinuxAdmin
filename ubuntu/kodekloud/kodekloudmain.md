## KodeKloud Devops
### servers
```bash
ssh tony@stapp01 -p 22
ssh steve@stapp02 -p 22
ssh banner@stapp03 -p 22

sshpass -p '' ssh -o StrictHostKeyChecking=no tony@stapp01 -p 22
sshpass -p '' ssh -o StrictHostKeyChecking=no steve@stapp02 -p 22

sshpass -p '' ssh -o StrictHostKeyChecking=no natasha@ststor01 -p 22

systemctl status [service]

yum install net-tools -y
yum install nano -y

ss -ntulp | grep 8080

```
- [lfcs essential cli](../lfcs_admin/essential_commands.md)
- [Linux 1](./Linux/linux1.md)
    - [Advanced1](./Linux/advanced1.md)
- [Devops 1](./Devops1/devops1.md)
    - [Web Services 1](./Devops1/linux_services/web_services1.md)
    - [Web Services 2](./Devops1/linux_services/web_services2.md)
    - [Git](./Devops1/git_tasks/git1.md)
    - [Docker 1](./Devops1/docker_tasks/docker1.md)
    - [Kubernetes](./Devops1/docker_tasks/kubernetes.md)
