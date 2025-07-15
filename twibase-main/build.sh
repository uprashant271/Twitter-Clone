#!/usr/bin/env bash
# Build script for Render.com

# Install dependencies
pip install -r requirements.txt

# Navigate to Django project
cd src/twipost

# Collect static files
python manage.py collectstatic --noinput

# Run database migrations
python manage.py migrate

echo "Build completed successfully!"
