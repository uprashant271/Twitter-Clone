# 🐦 Twibase - A Mini Twitter Clone

[![Docker Build](https://img.shields.io/badge/docker-ready-blue)](https://github.com/Ashutosh6123/twibase)
[![Python](https://img.shields.io/badge/python-3.11+-blue.svg)](https://python.org)
[![Django](https://img.shields.io/badge/django-5.2.3-green.svg)](https://djangoproject.com)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

Twibase is a full-stack Django web application that mimics core features of Twitter, allowing users to register, login, post tweets (with optional images), edit or delete them, and view all tweets in a responsive interface.

## 🔧 Features

- ✅ User Authentication (Register/Login/Logout)
- ✍️ Create, Edit & Delete Tweets
- 🖼️ Upload Images with Tweets
- 🧠 Form validation and CSRF protection
- 🖥️ Responsive UI with Bootstrap 5
- 📁 Media file handling with Django's `MEDIA_URL` and `MEDIA_ROOT`
- 🛠️ Django Admin Panel support

## 🛠️ Tech Stack

- **Backend**: Django 5.2
- **Database**: SQLite3
- **Frontend**: HTML5, CSS3, Bootstrap 5
- **Authentication**: Django's built-in auth system

## 📁 Project Structure

```
twipost-main/
├── .gitignore                   # Git ignore rules
├── .dockerignore               # Docker ignore rules
├── README.md                    # Project documentation
├── requirements.txt             # Python dependencies
├── render.yaml                 # Render.com deployment configuration
├── Dockerfile                   # Docker development image
├── Dockerfile.prod             # Docker production image
├── docker-compose.yml          # Docker development services
├── docker-compose.prod.yml     # Docker production services
├── venv/                       # Virtual environment (auto-generated)
├── docker/                     # Docker configuration files
│   ├── nginx.conf              # Nginx configuration
│   └── supervisord.conf        # Supervisor configuration
├── scripts/                    # Helper scripts
│   ├── dev-setup.sh           # Linux/macOS setup script
│   └── dev-setup.bat          # Windows setup script
└── src/                        # Source code directory
    └── twipost/                # Django project root
        ├── manage.py           # Django management script
        ├── db.sqlite3          # SQLite database
        ├── static/             # Static files (CSS, JS, images)
        ├── media/              # User-uploaded files
        │   └── photos/         # Tweet images
        ├── templates/          # Global templates
        │   ├── layout.html     # Base template
        │   └── registration/   # Authentication templates
        ├── tweet/              # Main Django app
        │   ├── models.py       # Data models
        │   ├── views.py        # Business logic
        │   ├── forms.py        # Django forms
        │   ├── urls.py         # App URL patterns
        │   ├── admin.py        # Admin configuration
        │   ├── templates/      # App-specific templates
        │   └── migrations/     # Database migrations
        └── twipost/            # Django project settings
            ├── settings.py     # Project configuration
            ├── urls.py         # Main URL routing
            └── wsgi.py         # WSGI application
```

## 🚀 Setup Instructions

### Option 1: Local Development (Traditional)

#### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/twibase.git
cd twipost-main
```

#### 2. Create and Activate Virtual Environment

```bash
# Create virtual environment
python -m venv venv

# Activate virtual environment
# On Windows:
venv\Scripts\activate
# On macOS/Linux:
source venv/bin/activate
```

#### 3. Install Dependencies

```bash
pip install -r requirements.txt
```

#### 4. Navigate to Django Project

```bash
cd src/twipost
```

#### 5. Run Database Migrations

```bash
python manage.py migrate
```

#### 6. Create Superuser (Optional)

```bash
python manage.py createsuperuser
```

#### 7. Run Development Server

```bash
python manage.py runserver
```

#### 8. Access the Application

- **Main Application**: http://127.0.0.1:8000/tweet/
- **Admin Panel**: http://127.0.0.1:8000/admin/

### Option 2: Docker Development (Recommended)

#### Prerequisites
- Docker Desktop installed
- Docker Compose installed

#### Quick Start

```bash
# Clone the repository
git clone https://github.com/yourusername/twibase.git
cd twipost-main

# Run setup script (Windows)
scripts\dev-setup.bat

# Or run setup script (Linux/macOS)
chmod +x scripts/dev-setup.sh
./scripts/dev-setup.sh
```

#### Manual Docker Setup

```bash
# Build and start services
docker-compose build
docker-compose up -d

# Run migrations
docker-compose exec web python manage.py migrate

# Create superuser
docker-compose exec web python manage.py createsuperuser

# View logs
docker-compose logs -f web
```

#### Docker Services
- **Web Application**: http://localhost:8000/tweet/
- **Admin Panel**: http://localhost:8000/admin/
- **PostgreSQL Database**: localhost:5432
- **Redis Cache**: localhost:6379

#### Docker Commands

```bash
# Stop services
docker-compose down

# Rebuild and restart
docker-compose down && docker-compose build && docker-compose up -d

# Access shell
docker-compose exec web bash

# View database
docker-compose exec db psql -U twibase_user -d twibase_db

# Backup database
docker-compose exec db pg_dump -U twibase_user twibase_db > backup.sql
```

### Option 3: Deploy to Render.com 🚀

Render.com provides an easy way to deploy your Django application with automatic builds and deployments.

#### Quick Deploy with Render.yaml

1. **Connect Repository**: Fork this repository and connect it to your Render account
2. **Auto-Deploy**: Render will automatically detect the `render.yaml` file and set up your services
3. **Environment Variables**: The following will be automatically configured:
   - `DATABASE_URL` - PostgreSQL connection string
   - `SECRET_KEY` - Auto-generated Django secret key
   - `DEBUG` - Set to `0` for production
   - `ALLOWED_HOSTS` - Set to `*` for Render domains

#### Manual Render Setup

1. **Create New Web Service**:
   - Connect your GitHub repository
   - Build Command: `pip install -r requirements.txt && cd src/twipost && python manage.py collectstatic --noinput && python manage.py migrate`
   - Start Command: `cd src/twipost && gunicorn twipost.wsgi:application --bind 0.0.0.0:$PORT`

2. **Add PostgreSQL Database**:
   - Create a new PostgreSQL service
   - Copy the connection string to your web service environment variables as `DATABASE_URL`

3. **Environment Variables**:
   ```
   SECRET_KEY=your-secret-key-here
   DEBUG=0
   ALLOWED_HOSTS=*
   DATABASE_URL=postgresql://user:pass@host:port/dbname
   ```

#### Render Services Architecture
- **Web Service**: Django application with Gunicorn + Whitenoise
- **PostgreSQL**: Managed database service  
- **Redis**: Cache service for sessions and performance
- **Auto-scaling**: Automatic scaling based on traffic

---

## 🎯 Usage

1. **Register**: Create a new account at `/tweet/register/`
2. **Login**: Sign in at `/accounts/login/`
3. **Create Tweets**: Click "Create a tweet" on the home page
4. **Upload Images**: Add optional images to your tweets
5. **Edit/Delete**: Manage your own tweets with edit/delete options
6. **Admin Panel**: Access Django admin for advanced management

##  Development

### Local Development
- **Django Version**: 5.2.3
- **Python Version**: 3.8+
- **Database**: SQLite (default), can be changed in `settings.py`
- **Static Files**: Stored in `src/twipost/static/`
- **Media Files**: User uploads in `src/twipost/media/photos/`

### Docker Development
- **Container**: Python 3.11-slim base image
- **Database**: PostgreSQL 15 (containerized)
- **Cache**: Redis 7 (containerized)
- **Web Server**: Django development server (dev) / Nginx + Gunicorn (prod)
- **Volumes**: Persistent data for database, static files, and media
- **Networking**: Custom bridge network for service communication

### Environment Variables
- `DEBUG`: Enable/disable debug mode (default: True)
- `SECRET_KEY`: Django secret key for security
- `DATABASE_URL`: PostgreSQL connection string
- `ALLOWED_HOSTS`: Comma-separated list of allowed hosts

### Docker Architecture
```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Web Container │    │ PostgreSQL DB   │    │  Redis Cache    │
│   (Django App)  │◄──►│   Container     │    │   Container     │
│   Port: 8000    │    │   Port: 5432    │    │   Port: 6379    │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │
         ▼
┌─────────────────┐
│   Host System   │
│   Port: 8000    │
└─────────────────┘
```

## 📝 License

This project is open source and available under the MIT License.
