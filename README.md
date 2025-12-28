*This project has been created as part of the 42 curriculum by ykamboua.*

# Inception
## Description

Inception is a System Administration project that consists of setting up a small Docker based infrastructure composed of three services:

- **MariaDB** database container (no nginx).
- **WordPress + php-fpm**  web application container (no nginx).
- **NGINX**  reverse proxy with TLSv1.2/TLSv1.3 only, serving as the sole entrypoint on port 443.

All services run in separate containers connected via a custom Docker network. Two bind mounted volumes persist the database and WordPress files in `/home/ykamboua/data`. Containers automatically restart on crash. The site is accessible at `https://ykamboua.42.fr`.

The project uses **Alpine 3.22** (penultimate stable version as of December 2025) for all containers.

## Project Description – Required Comparisons

### Docker and the sources included in the project
The infrastructure is fully containerized using Docker Compose. Each service has its own Dockerfile, configuration files, and startup scripts located in `srcs/requirements/<service>/`.

### Main design choices & comparisons

- **Virtual Machines vs Docker**  
  Virtual Machines emulate full operating systems (high overhead, slow startup). Docker containers share the host kernel, are lightweight, start in seconds, and provide process level isolation ideal for this multi service setup.

- **Secrets vs Environment Variables**  
  Docker secrets are the recommended way for sensitive data (passwords are injected as files in `/run/secrets`). This project uses environment variables via `.env` file (loaded with `env_file`) for simplicity while keeping credentials out of code and Git (`.env` is gitignored). Both approaches are secure when properly configured.

- **Docker Network vs Host Network**  
	A custom bridge network (`inception-net`) isolates containers and allows communication via service names (like `mariadb`, `wordpress:9000`). Host network would expose containers directly to the host network forbidden and less secure.

- **Docker Volumes vs Bind Mounts**  
	Named volumes are managed by Docker. This project uses bind mounts (`/home/ykamboua/data/...`) as explicitly required by the subject to make data directly accessible on the host machine.

## Instructions

### Prerequisites
- A virtual machine with Docker and Docker Compose installed.
- Add your domain to `/etc/hosts`:
  ```bash
  echo "127.0.0.1 ykamboua.42.fr" | sudo tee -a /etc/hosts

### Run the project
	From the project root:
``` make up -d      # to build && start all containers in background
	make down       # to sstop && remove containers
```
### Access
	Open in browser: `https://ykamboua.42.fr` (Accept the self-signed certificate warning)
	Complete the WordPress installation if needed (admin user can be created during setup)..

### Resources

	Official Docker documentation: `https://docs.docker.com/`
	Alpine Linux packages: `https://pkgs.alpinelinux.org/packages`
	NGINX documentation: `https://nginx.org/en/docs/`
	WordPress requirements: `https://wordpress.org/support/article/requirements/`
	OpenSSL self-signed certificates guide: `https://www.openssl.org/docs/`

### Additional references & tutorials

	42 Inception tutorial with bonus: `https://github.com/vbachele/Inception`
	Detailed Inception guide: `https://tuto.grademe.fr/inception/`
	Inception project walkthrough: `https://medium.com/@ssterdev/inception-42-project-part-ii-19a06962cf3b`
	Kali Linux VM images (useful for testing): `https://www.osboxes.org/kali-linux/`

### AI usage
AI was used to:
	Generate and debug Dockerfile snippets and startup scripts.
	Suggest improvements and fixes for common issues.
	Explain Docker concepts and error messages during development.