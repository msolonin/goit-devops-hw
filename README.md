# Як використовувати даний terraform код:

### 1. Піднімаемо всі ресурси такі як eks, vpc, ecr, argo_cd, jenkins, rds

```bash
terraform init
terraform plan
terraform apply
```

Всі ресурси піднято включно з RDS

![apply.png](pics/apply.png)

Змінюючи bool use_aurora true/false: в залежності від цього показника буде підняти aurora/postgressql

![rds.png](pics/rds.png)

### 2. Знищуемо всі ресурси:

In root folder:

```bash
terraform destroy
```
