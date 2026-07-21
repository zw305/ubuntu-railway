# Ubuntu XFCE Desktop on Railway

A lightweight Ubuntu 22.04 desktop running on Docker with **XFCE**, **TigerVNC**, **noVNC**, and **Firefox**. It can be deployed on Railway and accessed directly from a web browser.

---

## ✨ Features

* Ubuntu 22.04 LTS
* XFCE Desktop Environment
* Firefox Browser
* TigerVNC Server
* noVNC (Browser Access)
* HTTPS (Self-signed Certificate)
* Docker Ready
* Railway Deployment Ready

---

## 📁 Project Structure

```text
.
├── Dockerfile
├── start-vnc.sh
├── .dockerignore
└── README.md
```

---

## 🚀 Deploy on Railway

### 1. Fork or Clone

```bash
git clone https://github.com/<your-name>/ubuntu-railway.git
cd ubuntu-railway
```

---

### 2. Create a Railway Project

Create a new project on Railway and connect this GitHub repository.

Railway will automatically detect the Dockerfile and build the image.

---

### 3. Wait for Deployment

The build process may take several minutes because Ubuntu Desktop and Firefox are installed.

---

## 🌐 Access

After deployment, Railway will generate a public URL such as:

```text
https://your-project.up.railway.app
```

Open the URL in your browser.

---

## 🔑 Default VNC Password

```text
docker123
```

> Change the password before exposing the service to the Internet.

---

## 🖥 Desktop Environment

Installed software:

* XFCE Desktop
* Firefox
* XTerm
* Vim
* Git
* Curl
* Wget
* Net-tools

---

## 📦 Installed Packages

* xfce4
* xfce4-goodies
* tigervnc-standalone-server
* novnc
* websockify
* firefox
* vim
* curl
* wget
* git
* xterm

---

## 🔌 Ports

| Port | Service             |
| ---: | ------------------- |
| 5901 | TigerVNC            |
| 6080 | noVNC Web Interface |

---

## 🔒 Security Notice

This project uses:

* Self-signed SSL certificate
* Default VNC password

For production use, you should:

* Change the VNC password
* Replace the self-signed certificate with a trusted certificate
* Restrict public access if possible

---

## 🛠 Build Locally

```bash
docker build -t ubuntu-railway .
```

Run:

```bash
docker run -d \
  --name ubuntu-desktop \
  -p 6080:6080 \
  -p 5901:5901 \
  ubuntu-railway
```

Then open:

```text
https://localhost:6080
```

---

## 📄 License

This project is released under the MIT License.

---

## 🙏 Acknowledgements

This project is built using:

* Ubuntu 22.04 LTS
* XFCE
* TigerVNC
* noVNC
* websockify
* Docker
* Railway

---

## ⭐ Support

If you find this project useful, please consider giving it a ⭐ on GitHub.

Contributions, issues, and pull requests are welcome.
