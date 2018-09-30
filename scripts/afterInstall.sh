#!/bin/bash
sudo systemctl daemon-reload
sudo systemctl enable anup-routing.service
sudo systemctl start anup-routing
