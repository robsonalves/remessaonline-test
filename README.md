# Remessa Online Test

## Terraform

O terraform desenolvido tem a lógica de criação dos recursos que serão utilizados pela aplicação,
assim como a subida da aplicação propriamente dito no ECS/EC2 com autoscalling.

Você deve usar a versão do client do terraform 0.13, para garantir que todos 
executem a mesma versão do cliente, a linha 5 no arquivo main.tf, forçará que apenas client com este versão 
ou maior poderão rodar os scripts.


Comandos:
> terraform -v (verificar a versão do seu client)

> terraform init

> terraform plan


## Walkthrough Terraform

O primeiro passo de criação será a VPC, para ter uma rede básica, com NAT (permitindo a conexão da subnet a internet)
assim como subnets privadas, sem acesso de IP público, ideal para aplicações backend ou API, não ficarem expostas e
ter apenas um ponto de entrada gerenciável as APIs.

O segundo passo é a criação de um ECS Cluster e suas dependencias como, Logging do cloudwatch, Roles de acesso e o
auto-scalling que permitirá o Scalling out (horizontal) de novas máquinas caso seja necessário e até mesmo 
"desligar" os serviços do ECS, em caso de ambiente não produtivo.

o ECS-Cluster é um modulo do terraform que permite uma padronização na criação do recurso e o reaproveitamento, 
passamos pra ele apenas os parâmetros que ele espera no arquivo vars.tf do modulo (terraform/modules/ecs-cluster)

O alb é um módulo para criação de um application load balance, dentro dele está definido os target groups e 
listeners que o balance terá.

O application.tf é reposável pela criação do task definition e o service no ECS, assim rodando a aplicação.

Na definição existe algumas Tags Ancôras que serão substituídos durante um processo de CI/CD, por exemplo.

Uma dessas tags que estou referenciando é a $DOCKER_IMAGE, outras dessas estão no arquivo vars.tf do root da pasta 
terraform.

Logo, se quiser rodar o terraform plan, coloque algum valor no vars.tf do root do terraform.

ex:
> variable "aws_region" {
>  default = "us-east-1"
> }

> variable "environment" {
>   default = "$ENVIRONMENT"
> }

> variable "application" {
>   default = "$APPLICATION"
> }


# Nginx
Na pasta Nginx, tem um Dockerfile simples para a subida do Nginx e este dockerfile servirá como base para gerar uma imagem
imutável de uma aplicação e ela será referenciada no script application.tf durante o deploy.

As portas e outras definições vem das configurações do services do ECS (e do ALB)


# Gitlab
Na pasta Gitlab, tem um script inicial do gitlab, já iniciando uma separação lógica de build e deploy da aplicação, com a
execução do terraform, seguindo os comandos, terraform init, terraform validate e no release o terraform apply --auto-approve.

Note que em alguns passos existe um SED no arquivo *gitlab-ci* para replace das variáveis, simulando um deploy.


