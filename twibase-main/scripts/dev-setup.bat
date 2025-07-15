@echo off
REM Twibase Docker Development Setup Script for Windows

echo 🐳 Setting up Twibase Development Environment with Docker...

REM Check if Docker is installed
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Docker is not installed. Please install Docker Desktop first.
    pause
    exit /b 1
)

REM Check if Docker Compose is installed
docker-compose --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Docker Compose is not installed. Please install Docker Compose first.
    pause
    exit /b 1
)

REM Build and start development environment
echo 🔨 Building Docker images...
docker-compose build

echo 🚀 Starting development services...
docker-compose up -d

REM Wait for database to be ready
echo ⏳ Waiting for database to be ready...
timeout /t 10 /nobreak

REM Run migrations
echo 🗄️ Running database migrations...
docker-compose exec web python manage.py migrate

REM Create superuser (optional)
echo 👤 Creating superuser (optional)...
echo You can skip this by pressing Ctrl+C
docker-compose exec web python manage.py createsuperuser

echo ✅ Development environment is ready!
echo 🌐 Access your application at: http://localhost:8000/tweet/
echo 🛠️ Access Django admin at: http://localhost:8000/admin/
echo.
echo 📝 Useful commands:
echo   Stop services: docker-compose down
echo   View logs: docker-compose logs -f web
echo   Access shell: docker-compose exec web bash
pause
