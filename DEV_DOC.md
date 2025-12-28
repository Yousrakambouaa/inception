### DEV_DOC.md (Developer Documentation – How to Set Up & Maintain)

```markdown
# Developer Documentation – Inception

## Set Up the Environment from Scratch
1. Clone the repository.
2. Install Docker and Docker Compose on a virtual machine.
3. Create the data directories:
   ```bash
   mkdir -p /home/ykamboua/data/db_data /home/ykamboua/data/wordpress_files

### DEV_DOC.md (Developer Documentation – How to Set Up & Maintain)

```markdown
# Developer Documentation – Inception

## Set Up the Environment from Scratch
1. Clone the repository.
2. Install Docker and Docker Compose on a virtual machine.
3. Create the data directories:
   ```bash
   mkdir -p /home/ykamboua/data/db_data /home/ykamboua/data/wordpress_files

Manage Containers and Volumes

List containers: docker ps
View logs: docker logs <container_name>
Enter container: docker exec -it <container_name> sh
Reset data (fresh start):Bashmake down
sudo rm -rf /home/ykamboua/data/*
make up -d

Data Storage and Persistence

Database files: bind-mounted to /home/ykamboua/data/db_data
WordPress files: bind-mounted to /home/ykamboua/data/wordpress_files
Data survives container removal (make down) thanks to bind mounts.
All containers use Alpine 3.22 (penultimate stable as of December 2025).

Notes

No Docker secrets used – credentials in .env (gitignored).
Custom bridge network inception-net for internal communication.
Restart policy: always – containers auto-restart on crash.

