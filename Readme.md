# Multi region auto scaling web server build using Terraform and Google cloud

The architecture consists of an autoscaling managed instance group built within a custom VPC. Egress to internet is provided by NAT. Users are able to access the web hosted on this managed instance group via HTTPS load balancer.

## Modules

*   **`vpc`:** Custom VPC
*   **`network`:** NAT gateway and regional routers
*   **`inst_template`:** Creates instance template
*   **`mig`:** Managed instance group and autoscaler policy
*   **`lb`:** Load balancer configurations which includes forwarding rule, https proxy, SSL certificate creation and backend associations
*   **`firewall`:** Firewall rules for internet access, health check and SSH to compute instances
