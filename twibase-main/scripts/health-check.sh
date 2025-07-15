#!/bin/bash

# Health check script for Twibase Docker containers

echo "🔍 Checking Twibase Docker Health..."

# Check if containers are running
echo "📦 Container Status:"
docker-compose ps

echo ""
echo "🌐 Web Service Health:"
curl -f http://localhost:8000/tweet/ > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "✅ Web service is healthy"
else
    echo "❌ Web service is not responding"
fi

echo ""
echo "🗄️ Database Health:"
docker-compose exec -T db pg_isready -U twibase_user > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "✅ Database is healthy"
else
    echo "❌ Database is not responding"
fi

echo ""
echo "🔄 Redis Health:"
docker-compose exec -T redis redis-cli ping > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "✅ Redis is healthy"
else
    echo "❌ Redis is not responding"
fi

echo ""
echo "📊 Resource Usage:"
docker stats --no-stream --format "table {{.Container}}\t{{.CPUPerc}}\t{{.MemUsage}}" $(docker-compose ps -q)
