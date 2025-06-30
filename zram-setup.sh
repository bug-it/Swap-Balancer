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
echo "╔═══════════════════════════════════════════════╗"
echo "║        🚀 OTIMIZAÇÃO DE MEMÓRIA - ZRAM        ║"
echo "╚═══════════════════════════════════════════════╝"
echo -e "${RESET}"

# 🧠 Tamanho do ZRAM em GB (altere se desejar)
ZRAM_SIZE_GB=2

echo -e "${AZUL}🔧 Carregando módulo ZRAM...${RESET}"
sudo modprobe zram

# Verifica se /dev/zram0 foi criado
if [ ! -e /dev/zram0 ]; then
    echo -e "${VERMELHO}❌ Dispositivo ZRAM não encontrado! Verifique se seu kernel suporta ZRAM.${RESET}"
    exit 1
fi

echo -e "${AZUL}⚙️ Configurando algoritmo de compressão (${AMARELO}lzo${AZUL})...${RESET}"
echo lzo | sudo tee /sys/block/zram0/comp_algorithm >/dev/null

echo -e "${AZUL}📦 Definindo tamanho: ${AMARELO}${ZRAM_SIZE_GB}GB${AZUL}...${RESET}"
SIZE_BYTES=$((ZRAM_SIZE_GB * 1024 * 1024 * 1024))
echo $SIZE_BYTES | sudo tee /sys/block/zram0/disksize >/dev/null

echo -e "${AZUL}🛠️ Criando área de swap no ZRAM...${RESET}"
sudo mkswap /dev/zram0 >/dev/null

echo -e "${AZUL}🚀 Ativando swap ZRAM com prioridade alta...${RESET}"
sudo swapon -p 5 /dev/zram0

echo ""
echo -e "${VERDE}✅ ZRAM configurado com sucesso!${RESET}"
echo ""

echo -e "${CIANO}${NEGRITO}🔍 Estado atual do swap:${RESET}"
echo "═══════════════════════════════════════════════════════════"
swapon --show
echo "═══════════════════════════════════════════════════════════"
echo ""
