# Ansible

## Git Pull a Repo
```bash
ansible webserver -i inventory.ini -m git -a "repo=https://github.com/user/repo.git dest=/path/to/app version=main" --become
```

## Create PostgreSQL Database
```bash
ansible webserver -i inventory.ini -m community.postgresql.postgresql_db -a "name=mydb state=present" --become --become-user=postgres
```

## Create PostgreSQL User
```bash
ansible webserver -i inventory.ini -m community.postgresql.postgresql_user -a "name=myuser password=secretpass db=mydb priv=ALL state=present" --become --become-user=postgres
```

## Example: Configure iptables Rule (Open Port 80)
```bash
ansible webserver -i inventory.ini -m ansible.builtin.iptables -a "chain=INPUT protocol=tcp destination_port=80 jump=ACCEPT" --become
```

## Run Any Bash Command
```bash
ansible webserver -i inventory.ini -m shell -a "uptime && free -h" --become
```

**Note:** For PostgreSQL modules, you may need to install the collection first:
```bash
ansible-galaxy collection install community.postgresql
```

## 1. Full Server Setup Playbook
Save as `setup-server.yml`:
```yaml
---
- name: Configure webserver
  hosts: webserver
  become: yes
  
  tasks:
    # Git pull repository
    - name: Clone/pull application repo
      git:
        repo: https://github.com/user/repo.git
        dest: /var/www/myapp
        version: main
        update: yes

    # Create PostgreSQL database
    - name: Create application database
      community.postgresql.postgresql_db:
        name: myapp_db
        state: present
      become_user: postgres

    # Create PostgreSQL user
    - name: Create database user
      community.postgresql.postgresql_user:
        name: myapp_user
        password: "{{ db_password }}"
        db: myapp_db
        priv: ALL
        state: present
      become_user: postgres

    # Configure iptables - Web ports
    - name: Allow HTTP
      ansible.builtin.iptables:
        chain: INPUT
        protocol: tcp
        destination_port: 80
        jump: ACCEPT

    - name: Allow HTTPS
      ansible.builtin.iptables:
        chain: INPUT
        protocol: tcp
        destination_port: 443
        jump: ACCEPT

    - name: Allow SSH
      ansible.builtin.iptables:
        chain: INPUT
        protocol: tcp
        destination_port: 22
        jump: ACCEPT
```

## 2. Run the Playbook
```bash
# With password prompt
ansible-playbook -i inventory.ini setup-server.yml --ask-become-pass
```

## 3. Your inventory.ini structure
```ini
[webserver]
192.168.1.100 ansible_user=ubuntu ansible_ssh_private_key_file=/root/.ssh/id_gusserver
```
