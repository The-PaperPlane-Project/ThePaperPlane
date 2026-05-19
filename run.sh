#!/bin/bash

while true; do
    clear
    echo "====================================="
    echo "   ThePaperPlane Project Manager"
    echo "====================================="
    echo ""
    
    if docker ps 2>/dev/null | grep -q "paperplane"; then
        echo "Status: 🟢 Running"
    else
        echo "Status: 🔴 Stopped"
    fi
    
    echo ""
    echo "  [1] Start project"
    echo "  [2] Stop project"
    echo "  [3] Restart project"
    echo "  [4] View logs"
    echo "  [5] Open frontend"
    echo "  [6] Open API docs"
    echo "  [7] Rebuild project"
    echo "  [8] Status"
    echo ""
    echo "  [0] Exit"
    echo ""
    read -p "Choose option: " choice
    
    case $choice in
        1)
            echo "Starting project..."
            docker-compose up -d
            echo "Done!"
            read -p "Press Enter to continue..."
            ;;
        2)
            echo "Stopping project..."
            docker-compose down
            echo "Done!"
            read -p "Press Enter to continue..."
            ;;
        3)
            echo "Restarting project..."
            docker-compose restart
            echo "Done!"
            read -p "Press Enter to continue..."
            ;;
        4)
            docker-compose logs -f
            ;;
        5)
            open http://localhost:5173
            ;;
        6)
            open http://localhost:8000/docs
            ;;
        7)
            docker-compose down
            docker-compose up -d --build
            echo "Rebuilt!"
            read -p "Press Enter to continue..."
            ;;
        8)
            docker ps --filter "name=paperplane"
            read -p "Press Enter to continue..."
            ;;
        0)
            echo "Goodbye! 👋"
            exit 0
            ;;
    esac
done
