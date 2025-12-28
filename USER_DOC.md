# User Documentation – Inception

## Services Provided
This stack runs a complete WordPress website with:
- **MariaDB** – Database for storing posts, users, and settings.
- **WordPress + PHP-FPM** – The WordPress application itself.
- **NGINX** – Secure web server (HTTPS only) that serves the site and proxies requests to WordPress.

The only access point is **https://ykamboua.42.fr** on port 443.

## Start and Stop the Project
From the project root directory:
```bash
make up -d      # Start all containers in background
make down       # Stop and remove containers (data persists)
```
## Access the Website and Administration Panel

	Open in browser: https://ykamboua.42.fr
	Accept the self-signed certificate warning.
	Complete WordPress setup if first launch (create admin user).
	Admin panel: https://ykamboua.42.fr/wp-admin

### Credentials Management

Database credentials are stored in srcs/.env (gitignored).
WordPress admin user is created during initial setup or via the installer.
No passwords are hardcoded – all sensitive data is in .env.

### Check That Services Are Running
Bashdocker ps
Expected: three containers (mariadb, wordpress, nginx) with status Up.
Check logs if needed:
Bashdocker logs mariadb
docker logs wordpress
docker logs nginx
Data location (persisted):

Database: /home/ykamboua/data/db_data
WordPress files: /home/ykamboua/data/wordpress_files