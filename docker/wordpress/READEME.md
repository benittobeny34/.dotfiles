# For Mac:

```
    brew install mkcert nss
    mkcert -install
```

# For Ubuntu:

```sudo apt install libnss3-tools
    brew install mkcert # if you have Linuxbrew, or build from GitHub otherwise
    mkcert -install
```

# Generate wildcard SSL cert for \*.localhost

mkcert "\*.localhost"

You’ll get:

```
\_.localhost.pem (certificate)

\_.localhost-key.pem (private key)
```

Move them to a shared location:

```
mkdir -p ~/code/certs
mv \_localhost.pem ~/code/certs/cert.pem
mv \_localhost-key.pem ~/code/certs/key.pem
```

---------- DNSMASQ Setup ----------

> [!NOTE]

🔁 DNSMASQ (Optional: wildcard \*.localhost works with no /etc/hosts edit)
✅ macOS (using dnsmasq + resolver)
Install dnsmasq:

brew install dnsmasq
Add .localhost resolver:

echo "address=/.localhost/127.0.0.1" > /opt/homebrew/etc/dnsmasq.d/localhost.conf
Add DNS resolver:

sudo mkdir -p /etc/resolver
echo "nameserver 127.0.0.1" | sudo tee /etc/resolver/localhost
Restart dnsmasq:

sudo brew services restart dnsmasq
✅ Ubuntu / Linux (dnsmasq)
Edit /etc/dnsmasq.conf:

address=/.localhost/127.0.0.1
Then restart:

sudo systemctl restart dnsmasq

---
