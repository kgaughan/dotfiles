function show-cert
	echo | \
		openssl s_client -showcerts -servername $argv[1] -connect $argv[1]:443 2>/dev/null | \
		openssl x509 -inform pem -noout -text
end
