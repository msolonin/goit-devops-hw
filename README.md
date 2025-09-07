# Як використовувати даний terraform код:

### 1. Піднімаемо всі ресурси такі як eks, vpc, ecr, argo_cd, jenkins

```bash
terraform init
terraform plan
terraform apply
```

### 2. Заходимо на дженкінс виконуемо джобу або створюемо нову з використанням свог JenkinsFile

Jenkins:
admin
admin123

Argocd:
admin

```bash
kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath="{.data.password}" | base64 -d
echo
```

![jenkins.png](pics/jenkins.png)

Після запуску джоби на ноді береться код з папки django для створення нового контейнеру, контейнер пушиться в ecr, після цього в локальному репозиторії змінюеться тег та пушиться в репозиторій

### 3. Заходимо в argocd якщо дефолтний апп не працюе:

```bash
kubectl apply -f django-app-argo.yaml
```

для створення нового апп django-app, котрий буде чекаться з цього ж репозиторію

![argocd.png](pics/argocd.png)

### 5. Знищуемо всі ресурси:

In root folder:

```bash
terraform destroy
```
