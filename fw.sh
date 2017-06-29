#!/bin/sh

# ajout de module
#modprobe ip_conntrack
#modprobe ip_conntrack_irc
#modprobe ip_conntrack_ftp
#modprobe ip_nat_ftp

# remise à zéro des règles
sudo iptables -F
sudo iptables -t nat -F

# Politique par défault
sudo iptables -P INPUT DROP 
sudo iptables -P OUTPUT DROP 
sudo iptables -P FORWARD DROP

# Règles Flux DNS
sudo iptables -A INPUT -p udp --sport 53 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A OUTPUT -p udp --dport 53 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A INPUT -p tcp --sport 53 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A OUTPUT -p tcp --dport 53 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

# Règles HTTP (APT)
sudo iptables -A INPUT -p tcp --sport 80 -m state --state ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A OUTPUT -p tcp --dport 80 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A INPUT -p tcp --sport 443 -m state --state ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A OUTPUT -p tcp --dport 443 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

sudo iptables -A INPUT -p tcp --sport 8069 -m state --state ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A OUTPUT -p tcp --dport 8069 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT


# Règles envoie MAIL
sudo iptables -A INPUT -p tcp --sport 25 -m state --state ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A OUTPUT -p tcp --dport 25 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

# Règles HTTP (Apache)
sudo iptables -A INPUT -p tcp --dport 80 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A OUTPUT -p tcp --sport 80 -m state --state ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 443 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A OUTPUT -p tcp --sport 443 -m state --state ESTABLISHED,RELATED -j ACCEPT

# Règles connexion SSH
sudo iptables -A INPUT -p tcp --dport 22 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A OUTPUT -p tcp --sport 22 -m state --state ESTABLISHED,RELATED -j ACCEPT

# Authorisation pour le Rsynx
sudo iptables -A INPUT -p tcp --sport 22 -m state --state ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A OUTPUT -p tcp --dport 22 -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

# Règles ICMP (ping)
#sudo iptables -A OUTPUT -p icmp -j ACCEPT
#sudo iptables -A INPUT -p icmp -j ACCEPT

# Règles loopback
sudo iptables -A INPUT -i lo -j ACCEPT 
sudo iptables -A OUTPUT -o lo -j ACCEPT

# Règles pour le Flood
sudo iptables -A FORWARD -p tcp --syn -m limit --limit 1/second -j ACCEPT
sudo iptables -A FORWARD -p udp -m limit --limit 1/second -j ACCEPT
sudo iptables -A FORWARD -p icmp --icmp-type echo-request -m limit --limit 1/second -j ACCEPT
sudo iptables -A FORWARD -p tcp --tcp-flags SYN,ACK,FIN,RST RST -m limit --limit 1/s -j ACCEPT

# On log les paquets en entrée.
sudo iptables -A INPUT -j LOG
sudo iptables -A OUTPUT -j LOG

exit 0
