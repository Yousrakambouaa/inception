# User documentation – Inception

## Services provided
This stack runs a complete WordPress website with:
- **MariaDB** – Database for storing posts, users, and settings.
- **WordPress + PHP-FPM** – The WordPress application itself.
- **NGINX** – Secure web server (HTTPS only) that serves the site and proxies requests to WordPress.

The only access point is **https://ykamboua.42.fr** on port 443.

## Start and Stop the Project
From the project root directory:
`make up -d`	:to start all containers in background
`make down`		:to sstop and remove containers (data persists)

## Access the website and administration panel

Open in browser: https://ykamboua.42.fr
Accept the self signed certificate warning.
Complete WordPress setup if first launch (create admin user).
Admin panel: https://ykamboua.42.fr/wp-admin

### Credentials management

Database credentials are stored in srcs/.env (gitignored).
WordPress admin user is created during initial setup or via the installer.
No passwords are hardcoded, all sensitive data is in .env.

### Check that Services are running
`docker ps`	:Expected: three containers (mariadb, wordpress, nginx) with status Up.
Check logs if needed:
`docker logs mariadb`
`docker logs wordpress`
`docker logs nginx`
Data location (persisted):
Database: /`home/ykamboua/data/db_data`
WordPress files: `/home/ykamboua/data/wordpress_files`