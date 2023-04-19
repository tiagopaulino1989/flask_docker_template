# Define a imagem base do Docker
FROM python:3.9

# Configuraçoes de acessos ODBC
RUN apt-get update && \
    apt-get install -y unixodbc-dev && \
    rm -rf /var/lib/apt/lists/*

# Cria o diretório de trabalho
WORKDIR /app

# Copia o código fonte do app para o diretório /app
COPY . .

# Instala a biblioteca virtualenv
RUN pip install --upgrade pip
RUN pip install --user virtualenv

# Cria uma virtualenv chamada venv
RUN python -m virtualenv venv

# Ativa a virtualenv
SHELL ["/bin/bash", "-c"]
RUN source venv/bin/activate

# Instala as dependências do app
RUN pip install -r requirements.txt

# Adiciona o servidor web Nginx
RUN apt-get update && \
    apt-get install -y nginx && \
    rm -rf /var/lib/apt/lists/*

# Remove o arquivo de configuração padrão do Nginx
RUN rm /etc/nginx/sites-enabled/default

# Copia o arquivo de configuração personalizado do Nginx
COPY default.conf /etc/nginx/sites-enabled/

# Define a porta que será exposta pelo container
EXPOSE 80

# Executa o Gunicorn para rodar a aplicação Flask | Número de Workers: -w 2
CMD /usr/sbin/nginx -g "daemon off;" & gunicorn -w 2 --bind 0.0.0.0:5000 wsgi:app
