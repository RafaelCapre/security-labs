# Sysdig Monitoring - Kubernetes

This repository contains the structure to deploy and configure Sysdig for Kubernetes security and monitoring.

##  Installation

1. Clone the repository:
   ```sh
   git clone https://github.com/your-username/sysdig-monitoring.git
   ```
2. Navigate to the directory:
   ```sh
   cd sysdig-monitoring
   ```
3. Run the installation script:
   ```sh
   ./install-sysdig.sh
   ```

##  Configuration

- Modify **Sysdig settings** in `helm/values.yaml` before deployment.
- Customize security detection rules in `configs/custom-rules.yaml`.
- Deploy monitoring dashboards available in the `dashboards/` folder.

##  Features

- **Real-time security monitoring** of Kubernetes workloads.
- **Container runtime threat detection** using customizable rules.
- **Audit logs for Kubernetes API calls** to detect suspicious activities.
- **Integration with Grafana and SIEM tools** for enhanced observability.

##  References

- [Sysdig Official Documentation](https://sysdig.com/docs/)
- [Helm Chart for Sysdig](https://github.com/sysdiglabs/charts)

##  License

This project is open-source and licensed under the [MIT License](LICENSE).


