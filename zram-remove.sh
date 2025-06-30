#!/bin/bash

# 🎨 Cores
VERDE='\033[1;32m'
VERMELHO='\033[1;31m'
AMARELO='\033[1;33m'
AZUL='\033[1;34m'
CIANO='\033[1;36m'
NEGRITO='\033[1m'
RESET='\033[0m'

clear
echo -e "${CIANO}${NEGRITO}"
echo "╔════════════════════════════════════════════════╗"
echo "║           🗑️ REMOÇÃO DE ZRAM SWAP             ║"
echo "╚════════════════════════════════════════════════╝"
echo -e "${RESET}"

# Verifica se o dispositivo existe
if [ ! -e /dev/zram0 ]; then
    echo -e "${AMARELO}⚠️ Nenhum dispositivo ZRAM ativo encontrado.${RESET}"
else
    echo -e "${AZUL}🛑 Desativando swap no ZRAM...${RESET}"
    sudo swapoff /dev/zram0 2>/dev/null

    echo -e "${AZUL}🗑️ Resetando e liberando ZRAM...${RESET}"
    if [ -e /sys/block/zram0/reset ]; then
        echo 1 | sudo tee /sys/block/zram0/reset >/dev/null
    fi
fi

echo -e "${AZUL}❌ Removendo módulo ZRAM do kernel...${RESET}"
sudo modprobe -r zram 2>/dev/null

sleep 1

# Verificação final
if [ ! -e /dev/zram0 ]; then
    echo -e "${VERDE}✅ ZRAM removido com sucesso e sem rastros!${RESET}"
else
    echo -e "${VERMELHO}⚠️ Atenção: ZRAM ainda presente. Verifique manualmente.${RESET}"
fi

echo ""
echo -e "${CIANO}${NEGRITO}🔍 Estado atual do swap:${RESET}"
echo "═══════════════════════════════════════════════════════════"
swapon --show
echo "═══════════════════════════════════════════════════════════"
echo ""
