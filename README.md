# Kittygram Final

Репозиторий подготовлен под проектную работу с двумя независимыми pipeline:

- `.github/workflows/terraform.yml` для ручного управления инфраструктурой в Yandex Cloud через `plan`, `apply`, `destroy`.
- `.github/workflows/deploy.yml` для CI/CD приложения Kittygram после пуша в `main`.

## Что разворачивает Terraform

Конфигурация в директории `infra/` создаёт:

- VPC-сеть и подсеть.
- Security Group с входом только на `22` и `80`, а также полным исходящим трафиком.
- Виртуальную машину на Ubuntu 24.04 LTS.
- Object Storage bucket для проекта.
- Инициализацию VM через `cloud-init`, включая установку Docker Engine и Docker Compose plugin.

Terraform state хранится в S3-совместимом backend Yandex Object Storage. Имя backend bucket передаётся в workflow через секрет `TF_STATE_BUCKET`.

## Необходимые GitHub Secrets

### Для Terraform

- `YC_CLOUD_ID`
- `YC_FOLDER_ID`
- `YC_ZONE`
- `YC_SERVICE_ACCOUNT_KEY_JSON`
- `STORAGE_ACCESS_KEY`
- `STORAGE_SECRET_KEY`
- `TF_STATE_BUCKET`
- `SSH_PUBLIC_KEY`
- `USER`

### Для деплоя

- `HOST`
- `USER`
- `SSH_KEY`
- `SSH_PASSPHRASE`
- `DOCKERHUB_USERNAME`
- `DOCKERHUB_TOKEN`
- `POSTGRES_DB`
- `POSTGRES_USER`
- `POSTGRES_PASSWORD`
- `DJANGO_SECRET_KEY`
- `TELEGRAM_TO`
- `TELEGRAM_TOKEN`

## Полезные файлы

- `.env.example` — пример production-переменных.
- `tests.yml` — данные для ревьюерских автотестов.
- `kittygram_workflow.yml` — копия основного workflow деплоя для проверки структуры проекта.

## Локальная проверка

Для локального запуска тестов:

```bash
python -m venv venv
source venv/bin/activate
pip install -r backend/requirements.txt
pip install pytest requests pyyaml
pytest tests/test_files.py
```
