# Infra - AWS + Terraform + HCP Terraform

Repositorio GitHub: `FIAP-code-challenge/infra`

Projeto de infraestrutura modular em AWS com Terraform, backend remoto no HCP Terraform e separacao por ambientes (`dev` e `prod`).

## Status Atual

- Etapa 1: concluida (estrutura base + backend remoto HCP + integracao com GitHub)
- Etapa 2: concluida (modulo `vpc` integrado em `dev` e `prod`)
- Etapa 3: concluida (modulo `iam` integrado em `dev` e `prod`)
- OIDC GitHub Actions: implementado no codigo, porem desabilitado por padrao nos ambientes devido restricao de permissao IAM na conta atual

## Estrutura do Projeto

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
      ├── bootstrap/
      ├── vpc/
      ├── iam/
      └── README.md
```

## Ambientes e State Remoto

Workspaces HCP Terraform:

- `api-oficina-dev` (working directory: `envs/dev`)
- `api-oficina-prod` (working directory: `envs/prod`)

Organizacao HCP:

- `FIAP-tech-challenge-oficina`

Observacao:

- O `tfstate` e versionado no HCP Terraform (nao local).

## Modulos Implementados

### bootstrap

Modulo foundation/base do projeto para padrao inicial e evolucao de convencoes globais.

### vpc

Cria a camada de rede base:

- VPC
- Subnets publicas e privadas multi-AZ
- Internet Gateway
- Route tables e associacoes
- NAT Gateway opcional por ambiente

Defaults atuais:

- `dev`: NAT desligado
- `prod`: NAT ligado

### iam

Cria identidades base por feature flag:

- role ECS task execution
- role ECS task
- role Lambda execution
- OIDC provider + role GitHub Actions (quando habilitado)

Hardening implementado para OIDC:

- allowlist configuravel para `sub` (`github_oidc_allowed_subjects`)
- fallback seguro para branches `develop` e `main`
- validacao de entrada para evitar configuracao incompleta

## Fluxo de Trabalho

1. Alterar codigo em branch de feature/fix.
2. Rodar validacoes locais (`fmt`, `validate`, `plan`).
3. Abrir Pull Request.
4. Executar plan no HCP Terraform.
5. Aplicar (quando aprovado) conforme politica do workspace.

## Comandos de Validacao Local

```bash
terraform -chdir=envs/dev init
terraform -chdir=envs/dev fmt -recursive
terraform -chdir=envs/dev validate
terraform -chdir=envs/dev plan

terraform -chdir=envs/prod init
terraform -chdir=envs/prod fmt -recursive
terraform -chdir=envs/prod validate
terraform -chdir=envs/prod plan
```

## Seguranca e Observacoes Importantes

- OIDC (`enable_github_oidc`) esta `false` por padrao em `dev` e `prod` para evitar falha de apply em contas sem permissao `iam:CreateOpenIDConnectProvider`.
- Para habilitar OIDC, e necessario:
   - permissao IAM adequada para criar OIDC provider e role
   - configurar `enable_github_oidc = true`
   - definir/revisar `github_oidc_allowed_subjects`

## Proxima Etapa (Etapa 4)

Implementar camada de execucao da API com foco em:

- modulo ECR (repositorio de imagem)
- modulo ECS Fargate (cluster, service, task definition, logs)
- ALB + Security Groups
- integracao com VPC e IAM ja provisionados

## Convencoes de Git

- Branches curtas (`feat/...`, `fix/...`)
- PR para branch de integracao do time
- Conventional Commits

Exemplo:

```text
feat(iam): adicionar allowlist configuravel para subjects do github oidc
```
