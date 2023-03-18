; **********************************************************
; Base de Datos : example.com				   *
; **********************************************************
$TTL 3600
@	IN	SOA	ns1.example.com. hostmaster.example.com. (
			    2023010101	; Serial
			    7200	; Refresh
			    3600	; Retry;
			    432000	; Expire
			    36000 	; Minimun (negative caching TTL)
			    )

; **********************************************************
; Name Servers del Dominio				   *
; **********************************************************
; Servidor de nombres primario y secundario (NOC al cual se
; conecta) respectivamente.
		NS	ns1.example.com.
		NS	ns2.example.com.
		MX	1	mail.example.com.
		MX	5	mail1.example.com.
		PTR	localhost.

; **********************************************************
; INTERCAMBIADORES DE MAIL					   *
; **********************************************************
mail	IN	A	10.4.11.4
mail2	IN	A	10.4.11.31
; **********************************************************
; *                   Datos de los equipos                 *
; **********************************************************
; **********************************************************
; * Servidor DNS                                           *
; **********************************************************
ns1	IN	A	10.4.11.4
ns2	IN	A	10.4.11.30
; **********************************************************
; * Servidores WEB   					   *
; **********************************************************
host	IN	A	10.4.11.4
host5	IN	A	10.4.11.5
host6	IN	A	10.4.11.6
host7	IN	A	10.4.11.7
host8	IN	A	10.4.11.8

www	IN	CNAME	host
;img	IN	A	200.40.0.3
