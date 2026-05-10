## KodeKloud Devops
### servers
```bash
ssh tony@stapp01 -p 22
ssh steve@stapp02 -p 22
ssh banner@stapp03 -p 22

sshpass -p 'Ir0nM@n' ssh -o StrictHostKeyChecking=no tony@stapp01 -p 22
sshpass -p 'Am3ric@' ssh -o StrictHostKeyChecking=no steve@stapp02 -p 22

sshpass -p 'Bl@kW' ssh -o StrictHostKeyChecking=no natasha@ststor01 -p 22

systemctl status [service]

yum install net-tools -y
yum install nano -y

ss -ntulp | grep 8080

```
- [lfcs essential cli](../lfcs_admin/essential_commands.md)
- [Linux 1](./Linux/linux1.md)
    - [Advanced1](./Linux/advanced1.md)
- [Devops 1](./Devops1/devops1.md)
    - [Services 1](./Devops1/linux_services/services1.md)
    - [Services 2](./Devops1/linux_services/web_services.md)
    - [Git 1](./Devops1/git_tasks/git1.md)
