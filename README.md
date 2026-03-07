# FIAP Infra - AWS + Terraform + HCP Terraform

Este repositório começa pela **Etapa 1**: estrutura inicial, backend remoto no **HCP Terraform** (antigo Terraform Cloud) e integração com **GitHub** no modelo **VCS-driven**.

> Escopo desta etapa: **não** criar recursos AWS ainda. Somente fundação, versionamento e fluxo de execução.

## Estrutura do projeto

```text
.
├── envs/
│   ├── dev/
│   │   ├── main.tf
│   │   ├── providers.tf
│   │   ├── versions.tf
│   │   ├── variables.tf
│   │   ├── locals.tf
│   │   └── outputs.tf
│   └── prod/
│       ├── main.tf
│       ├── providers.tf
│       ├── versions.tf
│       ├── variables.tf
│       ├── locals.tf
│       └── outputs.tf
└── modules/
    └── README.md
```

## Teoria rápida (Etapa 1)

- `envs/dev` e `envs/prod` isolam configuração e state por ambiente.
- `modules/` será a base de reuso (VPC, IAM, ECS/Lambda, etc.) nas próximas etapas.
- O bloco `cloud` em `versions.tf` conecta o state ao HCP Terraform.
- O modo VCS-driven usa o GitHub para disparar `plan/apply` no HCP por PR/merge.
- Mesmo em VCS-driven, você valida localmente antes do push com `fmt/init/validate`.

## Pré-requisitos

- Terraform CLI instalado (versão recente).
- Conta no HCP Terraform com organização criada.
- Repositório no GitHub.

## Configuração no HCP Terraform (VCS-driven)

Crie dois workspaces no HCP Terraform:

- `api-oficina-dev`
- `api-oficina-prod`

Para cada workspace:

1. Conecte o VCS provider GitHub (GitHub App).
2. Aponte para este repositório.
3. Defina o **Working Directory**:
   - dev: `envs/dev`
   - prod: `envs/prod`
4. Configure branch e políticas de apply conforme seu fluxo:
   - sugestão inicial: plans em PR, apply apenas em merge para `main`.

## Decisão de arquitetura

- O módulo `bootstrap` permanece no projeto como módulo base/foundation.
- Ele continuará evoluindo para padrões comuns (naming, tags e convenções globais) sem acoplar recursos de negócio.
- A próxima fase técnica será o módulo de `vpc`.

## Validação local antes do push

```bash
terraform -chdir=envs/dev init
terraform -chdir=envs/dev fmt -recursive
terraform -chdir=envs/dev validate

terraform -chdir=envs/prod init
terraform -chdir=envs/prod fmt -recursive
terraform -chdir=envs/prod validate
```

## Fluxo de Git sugerido

- Branches curtas por feature: `feat/<tema>`
- Pull Request para `main`
- Conventional Commits

Exemplo de commit da Etapa 1:

```text
chore(terraform): bootstrap estrutura inicial com backend remoto no hcp
```
