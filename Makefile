
all:
	@echo "Use 'make install' to install p1-smartmeter on this system"

install:
	@cp src/p1_smartmeter.py /usr/local/bin/p1_smartmeter.py
	@cp src/p1_smartmeter.yaml /usr/local/etc/p1_smartmeter.yaml
	@cp systemd/p1_smartmeter.service /etc/systemd/system/p1_smartmeter.service

	@chmod 750 /usr/local/bin/p1_smartmeter.py
	@chmod 640 /usr/local/etc/p1_smartmeter.yaml
	@chmod 644 /etc/systemd/system/p1_smartmeter.service

	@systemctl daemon-reload
	@systemctl enable p1_smartmeter.service
	@echo "p1-smartmeter is installed and enabled as a systemd service, start it with the command 'systemctl start p1_smartmeter.service'"

# Removes personal information from the config.yaml
deploy_ready:
	@sed -i "s/^mqtt_username.*/mqtt_username: 'p1'/g" p1_smartmeter.yaml 
	@sed -i "s/^mqtt_password.*/mqtt_password: 'password'/g" p1_smartmeter.yaml 
	@sed -i "s/^mqtt_host.*/mqtt_host: '127.0.0.1'/g"  p1_smartmeter.yaml 
