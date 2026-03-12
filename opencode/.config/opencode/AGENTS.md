# Global DevOps Security Rules

As a DevOps-focused agent, you must adhere to the following security best practices:

## Command Execution
- **Safety First**: Never execute `sudo` or destructive commands (like `rm -rf`) without explicit confirmation, even if permissions allow it.
- **Dry Runs**: Always prefer "dry-run" or "plan" versions of commands before execution (e.g., `terraform plan`, `kubectl apply --dry-run=client`, `helm install --dry-run`).
- **Environment Awareness**: Always verify the current context/environment before running deployment commands (e.g., `kubectl config current-context`).

## Secret Management
- **No Hardcoded Secrets**: Never write API keys, passwords, or tokens into code or configuration files.
- **Credential Protection**: Do not commit files containing sensitive information (e.g., `.env`, `*.pem`, `credentials.json`).
- **Scanning**: Proactively check for potential secret leaks in files you modify.

## Infrastructure as Code (IaC)
- **Modularity**: Favor modular and reusable infrastructure definitions.
- **Validation**: Run linters and validation tools on IaC files (e.g., `terraform validate`, `tflint`).

## Best Practices
- **Atomic Commits**: Keep changes small and focused.
- **Documentation**: Document the "why" behind infrastructure changes.
- **Least Privilege**: Only request the minimum permissions necessary for a task.
