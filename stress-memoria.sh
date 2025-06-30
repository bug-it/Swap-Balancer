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
echo "╔════════════════════════════════════════════════════╗"
echo "║        🚀 SIMULADOR DE CARGA DE MEMÓRIA (RAM)      ║"
echo "╚════════════════════════════════════════════════════╝"
echo -e "${RESET}"

# Quantidade de processos simulando alocação
PROCESSOS=5
# Quantidade de memória por processo (em GB)
MEMORIA_GB=1
# Tempo em segundos que os processos ficarão ativos
TEMPO=600

echo -e "${AZUL}🔧 Iniciando ${PROCESSOS} processos para alocar ${MEMORIA_GB}GB de RAM cada...${RESET}"
echo ""

for i in $(seq 1 $PROCESSOS); do
    echo -e "${AMARELO}🚀 Iniciando processo ${i} alocando ${MEMORIA_GB}GB de RAM...${RESET}"
    python3 -c "a = ' ' * 1024 * 1024 * 1024 * $MEMORIA_GB; import time; time.sleep($TEMPO)" &
    sleep 0.5
done

echo ""
echo -e "${VERDE}✅ Todos os processos de carga de memória foram iniciados com sucesso!${RESET}"
echo -e "${CIANO}⏳ Eles permanecerão ativos por ${TEMPO} segundos (${TEMPO}s ≈ $(($TEMPO/60)) minutos).${RESET}"
echo ""

echo -e "${NEGRITO}🔍 Verifique o uso de memória com:${RESET}"
echo -e "${AMARELO}free -h${RESET}  ${CIANO}ou${RESET}  ${AMARELO}htop${RESET}  ${CIANO}ou${RESET}  ${AMARELO}watch -n 1 free -h${RESET}"
echo ""

echo -e "${AZUL}🛑 Para encerrar antes do tempo, execute:${RESET}"
echo -e "${VERMELHO}killall python3${RESET}  ${CIANO}ou${RESET}  ${VERMELHO}pkill -f 'time.sleep'${RESET}"
echo ""
