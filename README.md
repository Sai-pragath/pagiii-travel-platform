# Pagiii Travel Platform - Deployment Guide

A modern, responsive travel destination and product management platform built with Spring Boot and MySQL, featuring automated monitoring and a native Apache reverse proxy.

This guide provides a comprehensive, step-by-step tutorial to deploy this application from scratch, secure it with SSL, and monitor it using Prometheus and Grafana.

---

## Step 1: Clone the Repository & Start the Application

First, you need to connect to your Linux server via SSH and download the code.

1. **Log into your server**:
   ```bash
   ssh your_username@your_server_ip
   ```
2. **Clone the repository**:
   ```bash
   git clone https://github.com/Sai-pragath/pagiii-travel-platform.git
   cd pagiii-travel-platform
   ```
3. **Start the Database and Application**:
   We use Docker Compose to handle the Java compilation and database setup automatically.
   ```bash
   docker compose up -d --build
   ```
   *(This starts the Spring Boot app on internal port `8080`, MySQL on `3306`, Prometheus on `9090`, and Grafana on `3000`)*.

---

## Step 2: Configure the Native Apache Reverse Proxy

To serve the application securely, we use a native Apache server to proxy traffic to our Dockerized Spring Boot app. 

Run the automated setup script included in this repository:
```bash
./setup-apache.sh
```
*(This script installs Apache2, enables the proxy modules, creates the configuration file pointing port 80 to `http://127.0.0.1:8080`, and restarts Apache.)*

---

## Step 3: Open AWS EC2 Security Group Ports

Before the outside world can reach your server, you must open the necessary ports in your AWS dashboard.

1. Go to your **AWS EC2 Dashboard**.
2. Select your instance and click the **Security** tab at the bottom.
3. Click your **Security Group** link and click **Edit inbound rules**.
4. Add the following rules (Source: `Anywhere-IPv4` / `0.0.0.0/0`):
   - **HTTP** (Port 80)
   - **HTTPS** (Port 443)
   - **Custom TCP** (Port 9090) - *For Prometheus*
   - **Custom TCP** (Port 3000) - *For Grafana*
5. Click **Save rules**.

---

## Step 4: Configure DNS (cPanel)

Now you need to point your custom domain name to your server's IP address.

1. Log into your **cPanel** account.
2. Find the **Zone Editor** (under the Domains section).
3. Click **Manage** next to your domain.
4. Click **+ Add Record**:
   - **Name**: `yourdomain.com.` (include the trailing dot)
   - **Type**: `A`
   - **Record**: Paste your EC2 Server's Public IP address.
5. Click **Save Record**.
*(Note: DNS can take a few minutes to propagate. Wait until `http://yourdomain.com` successfully loads your application before proceeding to Step 5).*

---

## Step 5: Secure with SSL (Let's Encrypt / Certbot)

Once your domain is working on standard HTTP, you can easily secure it with a free SSL certificate.

1. **Install Certbot** on your server:
   ```bash
   sudo apt update
   sudo apt install certbot python3-certbot-apache -y
   ```
2. **Generate the SSL Certificate**:
   ```bash
   sudo certbot --apache
   ```
3. **Follow the prompts**: Enter your email, agree to the terms, and select your domain name. Certbot will automatically rewrite your Apache configuration to force HTTPS!

---

## Step 6: Application Monitoring (Prometheus & Grafana)

We have built-in enterprise monitoring! Your Spring Boot app exposes metrics at `/actuator/prometheus`, which are scraped by Prometheus and visualized by Grafana.

### Accessing Prometheus
- **URL**: `http://your-server-ip:9090`
- **Verify**: Go to **Status > Targets** and verify `spring-boot-app` is **UP**.

### Accessing Grafana
- **URL**: `http://your-server-ip:3000`
- **Login**: `admin` / `admin` *(You will be prompted to change the password).*
- **Setup Dashboard**:
  1. Go to **Connections > Data Sources** and add a **Prometheus** source.
  2. Set the URL to: `http://prometheus:9090`
  3. Click **Save & Test**.
  4. Go to **Dashboards > Import** and enter ID **`4701`** (a popular JVM dashboard) and click Load!
