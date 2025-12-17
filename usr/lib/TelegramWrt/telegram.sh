#!/bin/bash

CONFIG="/usr/lib/TelegramWrt/config"
PLUGIN_DIR="/usr/lib/TelegramWrt/plugins"
OFFSET_FILE="/usr/lib/TelegramWrt/offset"

# Funzione di log sul terminale
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"
}

# Rimuove eventuali caratteri CRLF dai plugin
for f in "$PLUGIN_DIR"/*; do
    [ -f "$f" ] && sed -i 's/\r$//' "$f"
done

# Carica TOKEN e CHAT_ID dal file config
if [ -f "$CONFIG" ]; then
    source "$CONFIG"
else
    log "[ERROR] Missing config file: $CONFIG"
    exit 1
fi

# Controlla che TOKEN sia definito
if [ -z "$TOKEN" ]; then
    log "[ERROR] TOKEN not defined in $CONFIG"
    exit 1
fi

# Carica offset da file o inizializza
if [ -f "$OFFSET_FILE" ]; then
    OFFSET=$(cat "$OFFSET_FILE")
else
    OFFSET=$(curl -s "https://api.telegram.org/bot$TOKEN/getUpdates" | jq '.result[-1].update_id // 0')
    OFFSET=$((OFFSET + 1))
fi

log "Bot started. Waiting for commands..."

# 🔔 Controllo messaggi di notifica al boot
if [ -f /etc/vpn_notify.msg ]; then
    OUTPUT=$(cat /etc/vpn_notify.msg)
    rm /etc/vpn_notify.msg

    # Invia il messaggio su Telegram
    curl -s -X POST "https://api.telegram.org/bot$TOKEN/sendMessage" \
        -d "chat_id=$CHAT_ID" --data-urlencode "text=$OUTPUT" > /dev/null

    log "Boot notification sent to Telegram."
fi

# Loop principale
while true; do
    RESPONSE=$(curl -s "https://api.telegram.org/bot$TOKEN/getUpdates?offset=$OFFSET&timeout=60")
    MESSAGE=$(echo "$RESPONSE" | jq -c '.result[0]')

    # Se non ci sono messaggi, continua
    if [ "$MESSAGE" = "null" ] || [ -z "$MESSAGE" ]; then
        continue
    fi

    UPDATE_ID=$(echo "$MESSAGE" | jq '.update_id')
    TEXT=$(echo "$MESSAGE" | jq -r '.message.text // empty')
    CHAT_ID=$(echo "$MESSAGE" | jq -r '.message.chat.id // empty')

    # Se non c'è testo, passa al prossimo
    if [ -z "$TEXT" ]; then
        OFFSET=$((UPDATE_ID + 1))
        echo "$OFFSET" > "$OFFSET_FILE"
        continue
    fi

    # Estrae comando e argomenti
    CMD=$(echo "$TEXT" | awk '{print $1}' | sed 's|^/||')   # rimuove / se presente
    ARG=$(echo "$TEXT" | cut -d' ' -f2-)

    log "Received command: /$CMD arg: '$ARG' from chat: $CHAT_ID"

    # Esecuzione plugin se esiste
    if [ -x "$PLUGIN_DIR/$CMD" ]; then
        OUTPUT=$("$PLUGIN_DIR/$CMD" "$ARG" 2>&1)
    else
        OUTPUT="? Command /$CMD not found!"
    fi

    # Invia la risposta su Telegram
    curl -s -X POST "https://api.telegram.org/bot$TOKEN/sendMessage" \
        -d "chat_id=$CHAT_ID" --data-urlencode "text=$OUTPUT" > /dev/null

    log "Executed /$CMD, response sent."

    # Aggiorna offset
    OFFSET=$((UPDATE_ID + 1))
    echo "$OFFSET" > "$OFFSET_FILE"
done

