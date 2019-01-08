#!/usr/bin/expect -f
# Script automatizzante per shell remote ssh -by shellx
# Questo script si collega ad una shell remota tramite il protocollo ssh, si logga ad essa e lancia dentro un comando bash
# Lo script viene processato e termina svolgendo il suo compito e permettendo subito dopo l_ interazione e output all_utente nella shell remota. Non ritorna alla shell locale, per ritornare bisogna disconnettersi manualmente con il comando logout

spawn ssh ipAddress
expect "password"
send "mypassword\r"
expect "# "
send "infodump.sh\r"
interact
