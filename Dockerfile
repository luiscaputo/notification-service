FROM node:23-slim
#TODO: downgfrade to 18-slim
# Instalação do NestJS CLI
RUN npm install -g @nestjs/cli@10.1.17

# Define o usuário
USER node

# Define o diretório de trabalho
WORKDIR /home/node/app

# Copia os arquivos do projeto, incluindo entrypoint.sh
COPY --chown=node:node . .

# Instala as dependências
RUN npm install

# Expõe a porta do serviço
EXPOSE 3000

# Copia e ajusta permissões do script de entrada
COPY --chown=node:node entrypoint.sh /home/node/app/
RUN chmod +x /home/node/app/entrypoint.sh

# Usa o script de entrada para iniciar a aplicação
CMD ["/home/node/app/entrypoint.sh"]
