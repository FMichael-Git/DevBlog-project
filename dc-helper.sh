#!/usr/bin/env bash

set -e

COMPOSE="docker compose"

show_help() {
cat << EOF
DevBlog Docker Compose Helper
=============================

Usage: ./dc-helper.sh <command> [service]

Commands:

  up [service]          Start all services, or a specific service
  down [service]        Stop all services, or a specific service
  build [service]       Build all services, or a specific service
  restart [service]     Restart all services, or a specific service
  logs [service]        View logs (all or specific). Use -f to follow
  status [service]      Show status of all or a specific container
  seed                  Create admin user (run seeding script)
  shell <service>       Open a shell inside a container (e.g., web, mongo)
  clean                 Stop containers and remove volumes (DESTRUCTIVE)
  help                  Show this help message

Services:

  web                   Node.js application (port 3000)
  mongo                 MongoDB database (port 27017)
  mongo-express         MongoDB web UI (port 8081)

Examples:

  ./dc-helper.sh up
  ./dc-helper.sh up mongo
  ./dc-helper.sh down web
  ./dc-helper.sh logs -f
  ./dc-helper.sh logs web
  ./dc-helper.sh build web
  ./dc-helper.sh restart mongo
  ./dc-helper.sh status
  ./dc-helper.sh shell web
  ./dc-helper.sh shell mongo
  ./dc-helper.sh seed
  ./dc-helper.sh clean
EOF
}

COMMAND=$1
SERVICE=$2

case "$COMMAND" in
  up)
    $COMPOSE up -d ${SERVICE}
    ;;
  down)
    $COMPOSE stop ${SERVICE}
    ;;
  build)
    $COMPOSE build ${SERVICE}
    ;;
  restart)
    $COMPOSE restart ${SERVICE}
    ;;
  logs)
    shift
    $COMPOSE logs "$@"
    ;;
  status)
    if [ -z "$SERVICE" ]; then
      $COMPOSE ps
    else
      $COMPOSE ps $SERVICE
    fi
    ;;
  shell)
    if [ -z "$SERVICE" ]; then
      echo "❌ Service name required (web | mongo | mongo-express)"
      exit 1
    fi

    if [ "$SERVICE" = "mongo" ]; then
      $COMPOSE exec mongo mongosh
    else
      $COMPOSE exec $SERVICE sh
    fi
    ;;
  seed)
    echo "🌱 Seeding database..."
    $COMPOSE exec web npm run seed
    ;;
  clean)
    echo "⚠️  WARNING: This will remove ALL containers and volumes!"
    read -p "Are you sure? (y/N): " confirm
    if [ "$confirm" = "y" ]; then
      $COMPOSE down -v
      echo "✅ Cleanup complete"
    else
      echo "❌ Cleanup cancelled"
    fi
    ;;
  help|"")
    show_help
    ;;
  *)
    echo "❌ Unknown command: $COMMAND"
    show_help
    exit 1
    ;;
esac
