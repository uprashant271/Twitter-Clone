#!/bin/bash

# Twibase Docker Development Setup Script

echo "🐳 Setting up Twibase Development Environment with Docker..."

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker first."
    exit 1
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose is not installed. Please install Docker Compose first."
    exit 1
fi

# Build and start development environment
echo "🔨 Building Docker images..."
docker-compose build

echo "🚀 Starting development services..."
docker-compose up -d

# Wait for database to be ready
echo "⏳ Waiting for database to be ready..."
sleep 10

# Run migrations
echo "🗄️ Running database migrations..."
docker-compose exec web python manage.py migrate

# Create superuser (optional)
echo "👤 Creating superuser (optional)..."
echo "You can skip this by pressing Ctrl+C"
docker-compose exec web python manage.py createsuperuser

echo "✅ Development environment is ready!"
echo "🌐 Access your application at: http://localhost:8000/tweet/"
echo "🛠️ Access Django admin at: http://localhost:8000/admin/"
echo ""
echo "📝 Useful commands:"
echo "  Stop services: docker-compose down"
echo "  View logs: docker-compose logs -f web"
echo "  Access shell: docker-compose exec web bash"
