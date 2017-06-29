#!/bin/bash

echo "Création du host $1"

echo "127.0.0.1	$1.fixe" | sudo tee --append /etc/hosts
