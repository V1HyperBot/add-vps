coin=$1
wallet=$2
workers=$3

if [ -z "$coin" ] || [ -z "$wallet" ] || [ -z "$workers" ]; then
  echo "🚫 Penggunaan: bash mining.sh coin wallet workers 🚫"
  exit 1
fi

echo "🔽 Download XMRig miner 🔽"
wget https://github.com/xmrig/xmrig/releases/download/v6.21.3/xmrig-6.21.3-linux-static-x64.tar.gz

echo "📦 Mengekstrak XMRig miner 📦"
tar -xf xmrig-6.21.3-linux-static-x64.tar.gz

echo "📂 Masuk ke direktori XMRig miner 📂"
cd xmrig-6.21.3 || exit 1

echo "#################################################"
echo "#              <⛏️ XMRIG MINER ⛏️>              #"
echo "#           🔄 ALGORITME RANDOM(X) 🔄           #"
echo "#################################################"

printf "| %-10s | %-$(expr length "$wallet")s | %-2s |\n" "COIN" "WALLET" "WORKERS"
printf "| %-10s | %-$(expr length "$wallet")s | %-2s |\n" "$coin" "$wallet" "$workers"
sleep 5

./xmrig -a rx -o stratum+ssl://rx.unmineable.com:443 -u $coin:$wallet.$workers -p x
